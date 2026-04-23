vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/echasnovski/mini.nvim",
})

vim.pack.add({
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

require("render-markdown").setup({
  completions = { blink = { enabled = true } },
  file_types = { "markdown" },
  heading = {
    icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
    position = "inline",
  },
  bullet = {
    icons = { "󰁕 ", "󰦺", "󱞪", "", "󱞩" },
  },
  checkbox = {
    checked = { rendered = " ", highlight = "Comment", scope_highlight = "Comment" },
    custom = {
      starred = {
        raw = "[~]",
        rendered = " ",
        highlight = "DiagnosticOk",
      },
      maybe = {
        raw = "[?]",
        rendered = " ",
        highlight = "DiagnosticWarn",
      },
    },
  },
})

-- vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { fg = "#BF68D9", bg = "#1F2329", bold = true })
-- vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { fg = "#4FA6ED", bg = "#1F2329", bold = true })
-- vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { fg = "#48B0BD", bg = "#1F2329", bold = true })
-- vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { fg = "#BF68D9", bg = "#4C2956", bold = true })
-- vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { fg = "#4FA6ED", bg = "#0B3D66", bold = true })
-- vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { fg = "#48B0BD", bg = "#1E4C52", bold = true })
