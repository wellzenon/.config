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
    heading = {
      icons = { ' 󰎤  ', ' 󰎧  ', ' 󰎪  ', ' 󰎭  ', ' 󰎱  ', ' 󰎳  ' },
      position = 'inline',
      backgrounds = {
        'Visual',
        'DiffChange',
        'CursorColumn',
        'DiffAdd',
        'DiffDelete',
        'DiffDelete',
      },
    },
    bullet = {
      icons = { '󰁕 ', '󰦺', '󱞪', '', '󱞩' },
    },
    checkbox = {
      checked = { highlight = 'Comment', scope_highlight = 'Comment' },
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
  },
}
