vim.pack.add({ "https://github.com/oskarnurm/koda.nvim" })

require("koda").setup({})
vim.cmd("colorscheme koda")

vim.keymap.set({ "n", "i", "x" }, "<f4>", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
    vim.cmd("colorscheme koda-light")

    vim.api.nvim_set_hl(0, "@markup.link.label", { fg = "#999999" })
    vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { fg = "#000000", bold = true })
    vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { fg = "#00aa88", italic = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownInlineHighlight", { bg = "#ffff88" })
  else
    vim.o.background = "dark"
    vim.cmd("colorscheme koda-dark")

    vim.api.nvim_set_hl(0, "NonText", { fg = "#474747" })
    vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", fg = "#474747" })

    vim.api.nvim_set_hl(0, "@markup.link.label", { fg = "#474747" })
    vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { fg = "#00aa88", italic = true })
    vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { fg = "#ffffff", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownInlineHighlight", { bg = "#444400" })
  end
end, { desc = "Toggle Dark/Light" })
