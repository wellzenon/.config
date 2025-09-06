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
      icons = { ' 󰅂 ', ' 󰄾 ', ' 󰶻 ', ' 󰶻 󰅂 ', ' 󰶻 󰄾 ', ' 󰶻 󰶻 ' },
      position = 'inline',
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
  config = function(_, opts)
    require('render-markdown').setup(opts)

    -- Override highlights
    vim.api.nvim_set_hl(0, '@markup.italic.markdown_inline', { fg = '#00aa88', italic = true })
    vim.api.nvim_set_hl(0, '@markup.strong.markdown_inline', { fg = '#ff8800', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownInlineHighlight', { bg = '#3a3a00' })

    vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg', { fg = '#1F2329', bg = '#BF68D9', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH2Bg', { fg = '#1F2329', bg = '#4FA6ED', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH3Bg', { fg = '#1F2329', bg = '#48B0BD', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg', { fg = '#BF68D9', bg = '#4C2956', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg', { fg = '#4FA6ED', bg = '#0B3D66', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH6Bg', { fg = '#48B0BD', bg = '#1E4C52', bold = true })
  end,
}
