return {
  'gruvw/strudel.nvim',
  build = 'npm install',
  config = function()
    require('plugin-pack.strudel').setup()
  end,
}
