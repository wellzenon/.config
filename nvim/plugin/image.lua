vim.pack.add({ "https://github.com/3rd/image.nvim" })

require("image").setup({
  -- max_width_window_percentage = 50,
  max_height_window_percentage = 80,
  integrations = {
    markdown = {
      only_render_image_at_cursor = false, -- defaults to false
      only_render_image_at_cursor_mode = "inline", -- "popup" or "inline", defaults to "popup"
    },
  },
  processor = "magick_cli",
})
