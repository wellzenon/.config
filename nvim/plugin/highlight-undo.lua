vim.pack.add({
  "https://github.com/tzachar/highlight-undo.nvim",
})

require("highlight-undo").setup({
  hlgroup = "HighlightUndo",
  duration = 300,
  pattern = { "*" },
  ignored_filetypes = {
    "neo-tree",
    "fugitive",
    "TelescopePrompt",
    "mason",
    "lazy",
    "Avante",
    "snacks_picker_list",
    "Scratch",
  },
  -- ignore_cb is in comma as there is a default implementation. Setting
  -- to nil will mean no default os called.
  -- ignore_cb = nil,
  -- ...
  ignore_cb = function(buf)
    local name = vim.api.nvim_buf_get_name(buf)
    return name:match("%.str$") ~= nil
  end,
})
