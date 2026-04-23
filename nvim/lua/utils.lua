local M = {}

function M.load_on_ft(ft, spec, config)
  local loaded = false

  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    callback = function()
      if loaded then
        return
      end
      loaded = true
      vim.pack.add(spec)
      if config then
        config()
      end
    end,
  })
end

return M
