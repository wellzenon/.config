vim.api.nvim_create_autocmd("BufReadPre", {
  group = vim.api.nvim_create_augroup("LazyLoadColorizer", { clear = true }),
  callback = function()
    vim.pack.add({ "https://github.com/catgoose/nvim-colorizer.lua" })

    local status, colorizer = pcall(require, "nvim-colorizer")
    if status then
      colorizer.setup({})
    end

    vim.api.nvim_del_augroup_by_name("LazyLoadColorizer")
  end,
})
