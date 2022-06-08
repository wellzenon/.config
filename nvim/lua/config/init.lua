local indent = 3

local config = {
   tabstop = indent,
   softtabstop = indent,
   shiftwidth = indent,
   expandtab = true,
   autoindent = true,
   copyindent = true,
   cursorline = true ,-- Enable highlighting of the current line
   cursorlineopt = "both",
   termguicolors = true, -- True color support
   relativenumber = true,
   number = true,
   incsearch = true,
   splitbelow = true,
   splitright = true,
   smartcase=true,
   smartindent=true,
   updatetime=300,
   showmode = false,
   undofile = true,
   swapfile = false,
   autowriteall = true,
   writeany = true,
   mouse="a",
-- Folding {{{
   foldenable=true,
   foldlevelstart=10,  -- default folding level when buffer is opened
   foldnestmax=10,     -- maximum nested fold
   foldmethod='indent',  -- fold based on indentation
-- }}} Folding
}

for key, value in pairs(config) do
   vim.opt[key]=value
end

-- set nvim python environment
vim.g.python3_host_prog = '$HOME/.local/venv/nvim/bin/python'
