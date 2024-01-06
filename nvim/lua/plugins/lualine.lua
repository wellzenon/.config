-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  darkblue = '#161721',
  greyblue = '#444A73',
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  pink   = '#FB9FD6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.blue },
    b = { fg = colors.blue, bg = colors.greyblue },
    c = { fg = colors.blue, bg = nil },
  },

  insert = { a = { fg = colors.black, bg = colors.pink } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.cyan, bg = nil },
    b = { fg = colors.cyan, bg = nil },
    c = { fg = colors.cyan, bg = nil },
  },
}

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "SmiteshP/nvim-navic" },
  opts = {

    options = {
      theme = bubbles_theme,
      component_separators = "|",
      section_separators = { left = " ", right = " " },
      -- section_separators = { left = " ", right = " " },
    },
    sections = {
      lualine_a = {
        {
          "mode",
          separator = { left = " ", right = " " },
          -- separator = { left = "", right = "" }, right_padding = 2
        },
      },
      lualine_b = { "branch" },
      lualine_c = {
        {
          "filename",
          -- path = 1,
        },
        {
          "navic",
          color_correction = "static",
          navic_opts = { highlight = true },
        },
        -- {
        --   "buffers",
        --   show_filename_only = false,
        --   separator = { right = "" },
        --   left_padding = 2,
        --   buffers_color = {
        --     -- Same values as the general color option can be used here.
        --     active = "lualine_b_normal", -- Color for active buffer.
        --     inactive = "lualine_c_normal", -- Color for inactive buffer.
        --   },
        -- },
      },
      -- lualine_x = { "navic" },
      lualine_y = { "fileformat", "filetype", "progress" },
      lualine_z = {
        {
          "location",
          separator = { left = " ", right = " " },
          left_padding = 2,
        },
      },
    },
    inactive_sections = {
      lualine_a = { "filename" },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { "location" },
    },
    extensions = { "neo-tree" },
    winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { "filename", path = 1 } },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    inactive_winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { "filename", path = 1 } },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    -- tabline = {
    --   lualine_a = {
    --     {
    --       "buffers",
    --       show_filename_only = false,
    --       buffers_color = {
    --         -- Same values as the general color option can be used here.
    --         active = "lualine_a_normal", -- Color for active buffer.
    --         inactive = "lualine_b_normal", -- Color for inactive buffer.
    --       },
    --     },
    --   },
    --   lualine_b = {},
    --   lualine_c = {},
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {},
    -- },
  },
}
