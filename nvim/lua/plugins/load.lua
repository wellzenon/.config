local use = require('packer').use

return require('packer').startup(function()
   use 'wbthomason/packer.nvim'
   use 'neovim/nvim-lspconfig' -- LSP Config
   use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
   use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
   use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
   use 'L3MON4D3/LuaSnip' -- Snippets plugin
   use 'simrat39/symbols-outline.nvim' -- Symbols tree plugin
   use "lukas-reineke/indent-blankline.nvim" -- ident lines
   use 'tpope/vim-surround' -- surround text with "'`([{
   use 'windwp/nvim-autopairs'
   use "hkupty/iron.nvim" -- Jupyter like functionality for .py files
   use {
      'kyazdani42/nvim-tree.lua',
      requires = {
         'kyazdani42/nvim-web-devicons', -- optional, for file icon
      }
   }
   use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
   }
   use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
   }
	use {
      "nvim-neorg/neorg",
      requires = "nvim-lua/plenary.nvim"
   }
   use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
   }
   use {'kdheepak/tabline.nvim'}
   --use {
   --   'akinsho/bufferline.nvim', -- Show buffer as Tabs
   --   tag = "v2.*",
   --   requires = {
   --      {'kyazdani42/nvim-web-devicons', opt = true}
   --   }
   --}
  -- themes
   use "EdenEast/nightfox.nvim"
   use "sainnhe/sonokai"
   use "folke/tokyonight.nvim"
   use "haishanh/night-owl.vim"
   use "navarasu/onedark.nvim"
end)
