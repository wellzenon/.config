return {
  -- {
  --   'projekt0n/github-nvim-theme',
  --   name = 'github-theme',
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require('github-theme').setup {
  --       options = {
  --         transparent = true,
  --       },
  --     }
  --     require('notify').setup {
  --       background_colour = '#00000000',
  --     }
  --
  --     vim.cmd 'colorscheme github_dark_colorblind'
  --   end,
  -- },

  -- {
  --   'rmehri01/onenord.nvim',
  --   config = function()
  --     require('onenord').setup {
  --       disable = {
  --         background = true,
  --         float_background = true,
  --       },
  --     }
  --   end,
  -- },

  -- {
  --   'zenbones-theme/zenbones.nvim',
  --   dependencies = 'rktjmp/lush.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.g.nordbones = {
  --       darken_comments = 05,
  --       darkness = 'warm',
  --     }
  --     -- vim.cmd.colorscheme 'seoulbones'
  --     -- vim.cmd.colorscheme 'nordbones'
  --     vim.cmd.colorscheme 'zenburned'
  --     -- vim.cmd.colorscheme 'kanagawabones'
  --     -- vim.cmd.colorscheme 'neobones'
  --     -- vim.cmd.colorscheme 'zenwritten'
  --     -- vim.cmd.colorscheme 'forestbones'
  --   end,
  -- },

  -- {
  --   'loctvl842/monokai-pro.nvim',
  --   priority = 1000,
  --   config = function()
  --     require('monokai-pro').setup {
  --       transparent_background = true,
  --       terminal_colors = true,
  --       devicons = true, -- highlight the icons of `nvim-web-devicons`
  --       styles = {
  --         comment = { italic = true },
  --         keyword = { italic = true }, -- any other keyword
  --         type = { italic = true }, -- (preferred) int, long, char, etc
  --         storageclass = { italic = true }, -- static, register, volatile, etc
  --         structure = { italic = true }, -- struct, union, enum, etc
  --         parameter = { italic = true }, -- parameter pass in function
  --         annotation = { italic = true },
  --         tag_attribute = { italic = true }, -- attribute of tag in reactjs
  --       },
  --       filter = 'ristretto', -- classic | octagon | pro | machine | ristretto | spectrum
  --       -- Enable this will disable filter option
  --       day_night = {
  --         enable = false, -- turn off by default
  --         day_filter = 'pro', -- classic | octagon | pro | machine | ristretto | spectrum
  --         night_filter = 'spectrum', -- classic | octagon | pro | machine | ristretto | spectrum
  --       },
  --       inc_search = 'background', -- underline | background
  --       background_clear = {
  --         -- "float_win",
  --         'toggleterm',
  --         'telescope',
  --         -- "which-key",
  --         'renamer',
  --         'notify',
  --         -- "nvim-tree",
  --         -- "neo-tree",
  --         -- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
  --       }, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
  --       plugins = {
  --         bufferline = {
  --           underline_selected = false,
  --           underline_visible = false,
  --         },
  --         indent_blankline = {
  --           context_highlight = 'default', -- default | pro
  --           context_start_underline = false,
  --         },
  --       },
  --     }
  --     vim.cmd.colorscheme 'monokai-pro'
  --   end,
  -- },

  -- {
  --   'olimorris/onedarkpro.nvim',
  --   priority = 1000, -- Ensure it loads first
  --   config = function()
  --     require('onedarkpro').setup {
  --       options = {
  --         cursorline = true, -- Use cursorline highlighting?
  --         transparency = true, -- Use a transparent background?
  --       },
  --     }
  --
  --     require('notify').setup {
  --       background_colour = '#00000000',
  --     }
  --
  --     vim.cmd 'colorscheme onedark'
  --   end,
  -- },

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
          keywords = 'bold',
          functions = 'none',
          strings = 'none',
          variables = 'none',
        },
        diagnostics = {
          darker = true, -- darker colors for diagnostic
          undercurl = true, -- use undercurl instead of underline for diagnostics
          background = false, -- use background color for virtual text
        },
        highlights = {
          ['Search'] = { fg = 'yellow', fmt = 'bold' },
        },
      }

      require('notify').setup {
        background_colour = '#00000000',
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
}
-- vim: ts=2 sts=2 sw=2 et
