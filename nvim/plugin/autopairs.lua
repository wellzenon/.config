vim.api.nvim_create_autocmd("InsertEnter", {
  group = vim.api.nvim_create_augroup("LazyLoadAutopairs", { clear = true }),
  callback = function()
    vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })

    local status, autopairs = pcall(require, "nvim-autopairs")
    if status then
      autopairs.setup({})
    end

    vim.api.nvim_del_augroup_by_name("LazyLoadAutopairs")
  end,
})
