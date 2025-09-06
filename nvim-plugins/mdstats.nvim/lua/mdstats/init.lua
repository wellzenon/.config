-- Código para adicionar texto virtual aos títulos Markdown

local M = {}

local cache = {
  last_hash = nil,
  last_buffer = nil,
}

M.defaults = {
  enabled = true,
  normal_mode_only = true,
  show_empty = false, -- Mostrar estatísticas em títulos sem tarefas
  debounce_ms = 200, -- Tempo de debounce para atualizações (em milissegundos)
  min_level = 1, -- Nível mínimo de título para mostrar estatísticas
  max_level = 6, -- Nível máximo de título para mostrar estatísticas
  -- hide_completed_tasks = true,
  icons = {
    left = '   ',
    completed = '󰿟',
    total = ' ',
    ratio = '󰏰  ',
  },
}

local options = {}

M.setup = function(opts)
  options = vim.tbl_deep_extend('force', M.defaults, opts or {})

  -- Inicializa o timer para debounce
  M.debounce_timer = vim.loop.new_timer()

  -- Configurar autocomandos
  M.setup_autocmds()
end

local ns_markdown_headings = vim.api.nvim_create_namespace 'mdstats_vtext'
-- local ns_hide_completed_tasks = vim.api.nvim_create_namespace 'mdstats_completed_vtext'

-- Verifica se o plugin deve estar ativo para o buffer atual
local function is_active_for_buffer()
  local active = options.enabled and vim.bo.filetype == 'markdown'
  local wrong_mode = options.normal_mode_only and vim.api.nvim_get_mode().mode ~= 'n'

  return active and not wrong_mode
end

-- Função para calcular um hash simples do conteúdo do buffer
local function buffer_hash()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  return vim.fn.sha256(table.concat(lines, '\n'))
end

M.clear_vtext = function()
  vim.api.nvim_buf_clear_namespace(0, ns_markdown_headings, 0, -1)
  -- vim.api.nvim_buf_clear_namespace(0, ns_hide_completed_tasks, 0, -1)
end

M.update_markdown_headings_vtext = function(opts)
  -- Verificar se o conteúdo do buffer foi alterado
  opts = opts or {}
  local force_update = opts.force_update or false

  local bufnr = vim.api.nvim_get_current_buf()
  local current_hash = buffer_hash()
  if not force_update and cache.last_hash == current_hash and cache.last_buffer == bufnr then
    return
  end
  cache.last_hash = current_hash
  cache.last_buffer = bufnr

  -- Limpa qualquer texto virtual anterior deste namespace no buffer atual
  M.clear_vtext()

  if not is_active_for_buffer() then
    return
  end

  -- Obtém o parser Treesitter para Markdown
  local ok, parser = pcall(vim.treesitter.get_parser)
  if not ok or not parser then
    vim.notify('Markdown parser não está disponível.', vim.log.levels.WARN)
    return
  end

  local tree = parser:parse()[1]
  local root = tree:root()

  local headings = {}
  local heading_stack = {}
  -- local completed = {}

  -- Função auxiliar para processar nós
  local function process_node(node)
    if not node or node:has_error() then
      return
    end

    local type = node:type()
    local start_row, _, _, _ = node:range()

    if type == 'atx_heading' or type == 'setext_heading' then
      local level = 0

      if type == 'atx_heading' then
        local marker = node:child(0)
        local _, _, _, end_col = marker:range()
        level = end_col
      elseif type == 'setext_heading' then
        for child in node:iter_children() do
          local child_type = child:type()
          if child_type == 'setext_h1_underline' or child_type == 'setext_h2_underline' then
            level = child_type == 'setext_h1_underline' and 1 or 2
            break
          end
        end
      end

      if level >= options.min_level and level <= options.max_level then
        local heading_info = {
          line = start_row,
          level = level,
          total = 0,
          completed = 0,
          children = {},
        }

        while #heading_stack > 0 and heading_stack[#heading_stack].level >= level do
          table.remove(heading_stack)
        end

        if #heading_stack > 0 then
          table.insert(heading_stack[#heading_stack].children, heading_info)
        else
          table.insert(headings, heading_info)
        end

        table.insert(heading_stack, heading_info)
      end
    elseif type == 'list_item' and #heading_stack > 0 then
      local current = heading_stack[#heading_stack]

      -- Procurar o marcador de tarefa no item da lista
      for child in node:iter_children() do
        local child_type = child:type()
        if child_type == 'task_list_marker_checked' then
          -- local completed_start, _, completed_end, _ = child:range()
          -- table.insert(completed, { completed_start, completed_end })
          current.total = current.total + 1
          current.completed = current.completed + 1
          break
        elseif child_type == 'task_list_marker_unchecked' then
          current.total = current.total + 1
          break
        else
          local child_text = vim.treesitter.get_node_text(child, 0)
          if child_text:match '%[.%]' then
            current.total = current.total + 1
            break
          end
        end
      end
    end

    for child in node:iter_children() do
      process_node(child)
    end
  end

  -- Iniciar o processamento a partir do nó raiz
  process_node(root)

  -- local hide_completed_tasks = function(completed_list)
  --   if not next(completed_list) or not options.hide_completed_tasks then
  --     return
  --   end
  --
  --   for _, task in ipairs(completed_list) do
  --     vim.api.nvim_buf_set_extmark(0, ns_hide_completed_tasks, task[1], 0, {
  --       conceal = 'x',
  --       conceal_lines = '',
  --     })
  --   end
  -- end

  -- Função auxiliar para calcular contagens cumulativas e adicionar texto virtual
  local function calculate_and_add_vtext(heading)
    -- Calcular contagens dos filhos recursivamente
    for _, child in ipairs(heading.children) do
      calculate_and_add_vtext(child)
      heading.completed = heading.completed + child.completed
      heading.total = heading.total + child.total
    end

    if heading.total > 0 or options.show_empty then
      local icons = options.icons
      local ratio = heading.total > 0 and heading.completed / heading.total or 0

      -- Formatar o texto virtual com a contagem e porcentagem
      local virtual_text_str =
        string.format('%s%d%s%d%s%.0f%s ', icons.left, heading.completed, icons.completed, heading.total, icons.total, ratio * 100, icons.ratio)

      -- local source_hl_name = '@markup.heading.' .. heading.level .. '.markdown'

      vim.api.nvim_buf_set_extmark(0, ns_markdown_headings, heading.line, 0, {
        virt_text = { { virtual_text_str } },
        virt_text_pos = 'eol',
        hl_mode = 'combine',
      })
    end
  end

  -- Processar títulos de nível superior
  for _, heading in ipairs(headings) do
    calculate_and_add_vtext(heading)
  end

  -- hide_completed_tasks(completed)
end

-- Função para executar atualização com debounce
M.debounced_update = function(opts)
  opts = opts or {}
  if M.debounce_timer then
    M.debounce_timer:stop()
    M.debounce_timer:start(
      options.debounce_ms,
      0,
      vim.schedule_wrap(function()
        M.update_markdown_headings_vtext(opts)
      end)
    )
  else
    -- Fallback se o timer não estiver disponível
    vim.defer_fn(M.update_markdown_headings_vtext, options.debounce_ms)
  end
end

M.setup_autocmds = function()
  pcall(vim.api.nvim_del_augroup_by_name, 'MarkdownStatsAuGroup')
  local augroup_md_stats = vim.api.nvim_create_augroup('MarkdownStatsAuGroup', { clear = true })

  vim.api.nvim_create_autocmd({
    'BufEnter',
    'BufWinEnter',
    'TextChanged',
    'TextChangedI',
  }, {
    pattern = { '*.md', '*.markdown' },
    callback = M.debounced_update,
    group = augroup_md_stats,
  })

  vim.api.nvim_create_autocmd({
    'ModeChanged',
  }, {
    pattern = '*:n',
    callback = function()
      M.debounced_update { force_update = true }
    end,
    group = augroup_md_stats,
  })

  vim.api.nvim_create_autocmd({
    'ModeChanged',
  }, {
    pattern = 'n:*',
    callback = M.clear_vtext,
    group = augroup_md_stats,
  })
end

M.create_commands = function()
  pcall(vim.api.nvim_del_user_command, 'MdStatsToggle')
  vim.api.nvim_create_user_command('MdStatsToggle', function()
    options.enabled = not options.enabled
    M.update_markdown_headings_vtext() -- Atualiza imediatamente
    local status_msg = options.enabled and 'Habilitado' or 'Desabilitado'
    vim.notify('Markdown Stats: ' .. status_msg, vim.log.levels.INFO, { title = 'Plugin' })
  end, { desc = 'Liga/desliga as estatísticas de cabeçalho Markdown.' })

  pcall(vim.api.nvim_del_user_command, 'MdStatsUpdate')
  vim.api.nvim_create_user_command('MdStatsUpdate', function()
    M.update_markdown_headings_vtext()
  end, { desc = 'Atualizar estatísticas de tarefas do Markdown' })
end

M.create_commands()

return M
