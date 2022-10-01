local colorscheme = "onedark"
vim.cmd [[highlight CursorLine guibg=#1B2131]]

require('onedark').setup {
   style = 'deep',
   transparent = true,  -- Show/hide background
   term_colors = true,
}
require('onedark').load()

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
