local indent = 3

vim.opt.tabstop = indent
vim.opt.softtabstop = indent
vim.opt.shiftwidth = indent
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.copyindent = true
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.cursorlineopt = "both"

vim.opt.termguicolors = true -- True color support

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.incsearch = true

-- Folding {{{
vim.opt.foldenable=true
vim.opt.foldlevelstart=10  -- default folding level when buffer is opened
vim.opt.foldnestmax=10     -- maximum nested fold
vim.opt.foldmethod='indent'  -- fold based on indentation
-- }}} Folding

-- set nvim python environment
vim.g.python3_host_prog = '$HOME/.local/venv/nvim/bin/python'

