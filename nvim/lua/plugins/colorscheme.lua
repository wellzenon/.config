return {
  -- -- Configure LazyVim to load catppuccin
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      transparent_background = true,
    },
  },
  --
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  --
  -- { "lunarvim/darkplus.nvim" },
  -- {
  --   "navarasu/onedark.nvim",
  --   opts = {
  --     style = "deep",
  --     transparent = true, -- Show/hide background
  --     term_colors = true,
  --   },
  -- },
  -- { "lunarvim/onedarker.nvim" },
  --
  -- -- Configure LazyVim to load tokyonight
  --
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = true,
  --   opts = {
  --     transparent = true,
  --     styles = {
  --       sidebars = "transparent",
  --       floats = "transparent",
  --     },
  --   },
  -- },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "tokyonight",
  --     style = "moon",
  --   },
  -- },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#222436",
      render = "compact",
      top_down = false,
    },
  },
}
