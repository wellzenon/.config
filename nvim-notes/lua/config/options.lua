-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

--light mode
-- vim.o.background = 'light'

-- Set window title
vim.opt.title = true
vim.opt.titlestring = 'notes'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = false
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.g.clipboard = {
    name = 'slackadays-clipboard',
    copy = {
      ['+'] = 'cb copy', -- Comando para copiar para a área de transferência do sistema (+)
      ['*'] = 'cb copy', -- Comando para copiar para a seleção primária (*) - pode ser igual ou diferente
    },
    paste = {
      ['+'] = 'cb paste', -- Comando para colar da área de transferência do sistema (+)
      ['*'] = 'cb paste', -- Comando para colar da seleção primária (*)
    },
    cache_enabled = 1, -- Habilita o cache (geralmente recomendado)
  }
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'no'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 0
vim.opt.cmdheight = 0

vim.opt.conceallevel = 2
vim.opt.concealcursor = 'n'

-- Hide tabs
vim.opt.showtabline = 0 -- Nunca mostrar a linha de abas
-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = false
vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
  precedes = '←',
  extends = '→',
  -- eol = '↲',
}

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

vim.g.lazyvim_blink_main = true
-- vim: ts=2 sts=2 sw=2 et
