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
        style = 'darker',
        transparent = true,
        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
        code_style = {
          comments = 'italic',
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
          ['CursorLine'] = { bg = '#232321' },
        },
      }

      require('notify').setup {
        background_colour = '#00000000',
      }
      -- Enable theme
      -- require('onedark').load()
    end,
  },
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_transparent_background = 2
      vim.g.gruvbox_material_enable_italic = true
      -- vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = true,
    opts = {
      terminal_colors = false, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = 'soft', -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = true,
    },
  },
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
      -- vim.cmd.colorscheme 'tokyonight-storm'
    end,
  },

  {
    'mcauley-penney/techbase.nvim',
    opts = {
      italic_comments = true,

      -- set to true to make the background, floating windows, statusline,
      -- signcolumn, foldcolumn, and tabline transparent
      transparent = true,

      plugin_support = {
        aerial = false,
        blink = true,
        edgy = false,
        gitsigns = true,
        hl_match_area = true,
        lazy = true,
        lualine = false,
        mason = true,
        mini_cursorword = false,
        nvim_cmp = false,
        vim_illuminate = false,
        visual_whitespace = false,
      },

      -- allows you to override any highlight group for finer-grained control
      hl_overrides = {},
    },
    init = function()
      vim.cmd.colorscheme 'techbase'
      vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'PMenu', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'FloatTitle', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none', fg = '#575a74' })
      vim.api.nvim_set_hl(0, 'NonText', { fg = '#575a74' })
    end,
    priority = 1000,
  },
}
-- vim: ts=2 sts=2 sw=2 et
