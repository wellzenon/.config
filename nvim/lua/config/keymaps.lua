-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Move to window using the <ctrl> hjkl keys
-- map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Go to left window" })
-- map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Go to lower window" })
-- map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Go to upper window" })
-- map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Go to right window" })

map("n", "<C-h>", "<cmd>KittyNavigateLeft<CR>", { desc = "Go to left window" })
map("n", "<C-j>", "<cmd>KittyNavigateDown<CR>", { desc = "Go to lower window" })
map("n", "<C-k>", "<cmd>KittyNavigateUp<CR>", { desc = "Go to upper window" })
map("n", "<C-l>", "<cmd>KittyNavigateRight<CR>", { desc = "Go to right window" })

map("i", "jk", "<ESC>", { desc = "jk fast to exit insert mode" })

map("i", "<C-CR>", "<Esc>o", { desc = "adds a line below on insert mode" })
map("n", "<C-CR>", "o<Esc>", { desc = "adds a line below on normal mode" })
map("n", "<s-enter>", "i<CR><Esc>", { desc = "breaks the line" })
