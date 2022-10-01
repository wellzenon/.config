local map = vim.api.nvim_set_keymap

-- get out of terminal mode
map('i', 'jj', '<Esc>', {})
map('t', 'jj', '<C-\\><C-n>', {})

local opts = { noremap = true }
local opts_silent = { noremap=true, silent=true }

-- local cmd = vim.cmd

-- This is a wrapper function made to disable a plugin mapping from chadrc
-- If keys are nil, false or empty string, then the mapping will be not applied
-- Useful when one wants to use that keymap for any other purpose

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http<cmd> ://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour

-- map({ "n", "x", "o" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
-- map({ "n", "x", "o" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
-- map("", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
-- map("", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

-- use ESC to turn off search highlighting
map("n", "<Esc>", "<cmd> :noh <CR>", opts)

--navigation between bufferlines tabs
map("n", "<A-h>", ":TablineBufferNext <cr>", opts_silent)
map("n", "<A-l>", ":TablineBufferPrevious <cr>", opts_silent)
map("t", "<A-h>", "<C-\\><C-N> :TablineBufferNext <cr>", opts_silent)
map("t", "<A-l>", "<C-\\><C-N> :TablineBufferPrevious <cr>", opts_silent)

-- navigation between windows
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-k>", "<C-w>k", opts)

map("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)

-- resizing windows
map("n", "<A-->", "<C-w>-", opts)
map("n", "<A-=>", "<C-w>+", opts)
map("n", "<A-,>", "<C-w><", opts)
map("n", "<A-.>", "<C-w>>", opts)


-- move cursor within insert mode
map("i", "<C-h>", "<Left>", opts)
map("i", "<C-e>", "<End>", opts)
map("i", "<C-l>", "<Right>", opts)
map("i", "<C-j>", "<Down>", opts)
map("i", "<C-k>", "<Up>", opts)
map("i", "<C-a>", "<ESC>^i", opts)

-- move lines
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
map("i", "<C-CR>", "<Esc>o", opts) -- adds a line below on insert mode
map("n", "<C-CR>", "o<Esc>", opts) -- adds a line below on insert mode

map("n", "<C-c>", "<cmd> :%y+ <CR>", opts) -- copy whole file content
map("n", "<S-t>", "<cmd> :enew <CR>", opts) -- new buffer
map("n", "<C-t>b", "<cmd> :tabnew <CR>", opts) -- new tabs
map("n", "<leader>n", "<cmd> :set nu! <CR>", opts)
map("n", "<leader>rn", "<cmd> :set rnu! <CR>", opts) -- relative line numbers

-- nvim-tree
map("n", "<leader>z", "<cmd> :NvimTreeToggle <CR>", opts)

-- fast have and close
map("n", "<C-q>", "<cmd> :bd <CR>", opts)
map('i', "<C-q>", '<Esc>:bd<cr>', opts)
map("n", "<C-s>", "<cmd> :w <CR>", opts) -- ctrl + s to save file
map('i', "<C-s>", '<Esc>:w<cr>a', opts)

-- nvim-telescope
map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)

-- LSP keybindings
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts_silent)
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts_silent)
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts_silent)
map('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts_silent)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr) -- Enable completion triggered by <c-x><c-o> vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
   -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local buf_map = vim.api.nvim_buf_set_keymap
  buf_map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts_silent)
  buf_map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts_silent)
  buf_map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts_silent)
  buf_map(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts_silent)
  buf_map(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts_silent)
  buf_map(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts_silent)
  buf_map(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts_silent)
  buf_map(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts_silent)
  buf_map(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts_silent)
  buf_map(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts_silent)
  buf_map(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts_silent)
  buf_map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts_silent)
  buf_map(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format {async = true} <CR>', opts_silent)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver', 'pyright', 'cssls' }

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
 }
end

--svelte LSP
require'lspconfig'.svelte.setup {
   on_attach = on_attach,
   capabilities = capabilities,
   cmd = { "svelteserver", "--stdio" },
   filetypes = { "svelte", "html"},
}

-- lua LSP
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  on_attach = on_attach,
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
   { name = 'nvim_lsp' },
   { name = 'luasnip' },
--   { name = 'orgmode' },
--   { name = 'neorg' },
  }--, {
--     { name = 'buffer' },
--  }
}

-- symbols-outline keymaps
map("n", "<leader>x", "<cmd> :SymbolsOutline <CR>", opts)
vim.g.symbols_outline = {
    keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = {"<Esc>", "q"},
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        toggle_preview = "K",
        rename_symbol = "r",
        code_actions = "a",
    },
}

