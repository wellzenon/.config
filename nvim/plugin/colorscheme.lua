vim.pack.add({ "https://github.com/oskarnurm/koda.nvim" })

require("koda").setup()

local function set_background(action)
  local target = vim.o.background

  if action == "light" or action == "dark" then
    target = action
  elseif action ~= "reload" then
    target = target == "light" and "dark" or "light"
  end

  if target == "light" then
    vim.o.background = "light"
    vim.cmd("colorscheme koda-light")

    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#dddddd" })
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#bbbbbb" })
    vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", fg = "#bbbbbb" })
    -- vim.api.nvim_set_hl(0, "FloatTitle", { bg = "#dddddd", bold = true })

    vim.api.nvim_set_hl(0, "@markup.link.label", { fg = "#999999" })
    vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { fg = "#000000", bold = true })
    vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { fg = "#00aa88", italic = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownInlineHighlight", { fg = "#000000", bg = "#ffff88" })

    vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { fg = "#ffffff", bg = "#000000", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { fg = "#ffffff", bg = "#444444", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { fg = "#ffffff", bg = "#888888", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { bg = "#aaaaaa", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { bg = "#cccccc", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { bg = "#eeeeee", bold = true })
  else
    vim.o.background = "dark"
    vim.cmd("colorscheme koda-dark")

    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#111111" })
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#444444" })
    vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", fg = "#444444" })
    -- vim.api.nvim_set_hl(0, "FloatTitle", { bg = "#111111", bold = true })
    -- vim.api.nvim_set_hl(0, "NonText", { fg = "#474747", bg = "none" })

    vim.api.nvim_set_hl(0, "@markup.link.label", { fg = "#474747" })
    vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { fg = "#00aa88", italic = true })
    vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { fg = "#ffffff", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownInlineHighlight", { fg = "#ffffff", bg = "#333366" })

    vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { fg = "#000000", bg = "#ffffff", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { fg = "#000000", bg = "#bbbbbb", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { fg = "#000000", bg = "#777777", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { bg = "#333333", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { bg = "#222222", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { bg = "#111111", bold = true })
  end
end

vim.keymap.set({ "n", "i", "x" }, "<f4>", function()
  set_background("toggle")
end, { desc = "Toggle Dark/Light" })

set_background("reload")
