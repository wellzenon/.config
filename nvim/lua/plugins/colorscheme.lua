return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        transparent = true,
        styles = {
          sidebars = 'transparent',
          floats = 'transparent',
          comments = { italic = false },
        },
      }
      vim.cmd.colorscheme 'tokyonight-storm'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
