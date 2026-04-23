vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("LazyLoadTodo", { clear = true }),
  callback = function()
    vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })
    vim.pack.add({ "https://github.com/folke/todo-comments.nvim" })

    local status, todo = pcall(require, "todo-comments")
    if status then
      todo.setup({})
    end

    vim.api.nvim_del_augroup_by_name("LazyLoadTodo")
  end,
})
