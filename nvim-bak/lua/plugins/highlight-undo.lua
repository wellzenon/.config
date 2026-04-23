return {
  'tzachar/highlight-undo.nvim',
  config = function()
    require('plugin-pack.highlight-undo').setup {
      hlgroup = 'HighlightUndo',
      duration = 300,
      pattern = { '*' },
      ignored_filetypes = { 'neo-tree', 'fugitive', 'TelescopePrompt', 'mason', 'lazy' },
      -- ignore_cb is in comma as there is a default implementation. Setting
      -- to nil will mean no default os called.
      -- ignore_cb = nil,
      -- ...
      ignore_cb = function(buf)
        local name = vim.api.nvim_buf_get_name(buf)
        return name:match '%.str$' ~= nil
      end,
    }
  end,
}
