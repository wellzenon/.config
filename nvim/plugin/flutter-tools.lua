local function is_flutter_project()
  local raw_result = vim.fn.findfile('pubspec.yaml', '.;')
  local pubspec = tostring(type(raw_result) == 'table' and raw_result[1] or raw_result)
  if pubspec == '' then
    return false
  end
  local file = io.open(pubspec, 'r')
  if not file then
    return false
  end
  local contents = file:read '*a'
  file:close()
  return contents:match 'flutter'
end

local function set_flutter_keymaps(bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  map('n', '<leader>cd', '<cmd>FlutterDebug<cr>', 'Flutter: Force run in debug mode')
  map('n', '<leader>cD', '<cmd>FlutterDevices<cr>', 'Flutter: List connected devices')
  map('n', '<leader>ce', '<cmd>FlutterEmulators<cr>', 'Flutter: List emulators')
  map('n', '<leader>cq', '<cmd>FlutterQuit<cr>', 'Flutter: Ends Flutter session')
  map('n', '<leader>cR', '<cmd>FlutterRun<cr>', 'Flutter: Run current project')
  map('n', '<leader>cS', '<cmd>FlutterRestart<cr>', 'Flutter: Hot Restart project')
  map('n', '<leader>ct', '<cmd>FlutterDevToolsActivate<cr>', 'Flutter: Activate Dart DevTools')
  map('n', '<leader>cT', '<cmd>FlutterDevTools<cr>', 'Flutter: Start Dart DevTools server')
end

vim.api.nvim_create_augroup('FlutterProjectDetection', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter', 'DirChanged' }, {
  group = 'FlutterProjectDetection',
  callback = function(args)
    if is_flutter_project() then
      set_flutter_keymaps(args.buf)
    end
  end,
})

return {
  'nvim-flutter/flutter-tools.nvim',
  lazy = false,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = true,
  opts = {
    widget_guides = { enabled = true },
    lsp = {
      color = { enabled = true },
      -- "always" is used by FlutterRename so it'll automatically update and rename imports
      settings = { renameFilesWithClasses = 'always' },
      on_attach = function(_client, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, {
            buffer = bufnr, -- Torna o atalho local para o buffer atual
            noremap = true, -- Boa prática, evita remapeamento recursivo
            silent = true, -- Não ecoa o comando
            desc = desc,
          })
        end

        map('n', '<leader>co', '<cmd>FlutterOutlineToggle<cr>', 'Flutter: Toggle outline')
        map('n', '<leader>cO', '<cmd>FlutterOutlineOpen<cr>', 'Flutter: Open outline')
        map('n', '<leader>cr', '<cmd>FlutterRename<cr>', 'Flutter: Rename (updates imports)')
        map('n', '<leader>cs', '<cmd>FlutterSuper<cr>', 'Flutter: Go to super class')
      end,
    },
  },
}
