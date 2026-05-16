vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/echasnovski/mini.nvim",
})

vim.pack.add({
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

require("render-markdown").setup({
  completions = { blink = { enabled = true } },
  file_types = { "markdown", "Avante", "avante", "AvanteInput" },
  heading = {
    icons = {
      "󰲠 ",
      "󰲢 ",
      "󰲤 ",
      "󰲦 ",
      "󰲨 ",
      "󰲪 ",
    },
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
