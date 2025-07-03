return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    completions = { blink = { enabled = true } },
    file_types = { 'markdown' },
    checkbox = {
      checked = {
        highlight = 'Comment',
        scope_highlight = 'Comment',
        -- rendered = ''
      },
      custom = {
        starred = {
          raw = '[~]',
          rendered = ' ',
          highlight = 'DiagnosticOk',
        },
        maybe = {
          raw = '[?]',
          rendered = ' ',
          highlight = 'DiagnosticWarn',
        },
      },
    },
    heading = {
      sign = false,
      -- below = '█',
      -- above = '█',
      -- left_pad = { 0.5, 0, 0, 0, 0, 0 },
      -- right_pad = 7,
      -- border = true,
      -- border_virtual = true,
      -- -- border_prefix = true,
      position = 'inline',
      -- width = { 'full', 'block', 'block', 'block', 'block', 'block', 'block' },
      icons = {
        '█ ',
        '██ ',
        '███ ',
        '████ ',
        '█████ ',
        '██████ ',
      },
    },
  },
}
