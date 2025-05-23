return {
  {
    'navarasu/onedark.nvim',
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('onedark').setup {
        style = 'warm',
        transparent = true,
        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
        code_style = {
          comments = 'none',
          keywords = 'none',
          functions = 'none',
          strings = 'none',
          variables = 'none',
        },
        diagnostics = {
          darker = true, -- darker colors for diagnostic
          undercurl = true, -- use undercurl instead of underline for diagnostics
          background = false, -- use background color for virtual text
        },
      }

      require('notify').setup {
        background_colour = '#000000',
      }
      -- Enable theme
      require('onedark').load()
    end,
  },
  -- {
  --   'folke/tokyonight.nvim',
  --   priority = 1000,
  --   config = function()
  --     ---@diagnostic disable-next-line: missing-fields
  --     require('tokyonight').setup {
  --       transparent = true,
  --       styles = {
  --         sidebars = 'transparent',
  --         floats = 'transparent',
  --         comments = { italic = false },
  --       },
  --     }
  --     vim.cmd.colorscheme 'tokyonight-storm'
  --   end,
  -- },
  -- {
  --   'ellisonleao/gruvbox.nvim',
  --   priority = 1000,
  --   config = true,
  --   opts = {
  --     italic = {
  --       strings = true,
  --       emphasis = true,
  --       comments = false,
  --       operators = false,
  --       folds = true,
  --     },
  --     transparent_mode = false,
  --   },
  -- },
}
-- vim: ts=2 sts=2 sw=2 et
