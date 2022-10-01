local use = require('packer').use

return require('packer').startup(function()
   use 'wbthomason/packer.nvim'

   -- LSP and completion
   use 'neovim/nvim-lspconfig' -- LSP Config
   use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
   use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
   use 'hrsh7th/cmp-buffer'
   use 'hrsh7th/cmp-path'
   use 'hrsh7th/cmp-cmdline'
   use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
   use 'L3MON4D3/LuaSnip' -- Snippets plugin
   use 'dense-analysis/ale' -- Asynchronous Lint Engine
   use "RRethy/vim-illuminate"
--   use 'burner/vim-svelte' --svelte plugin
--   use 'leafOfTree/vim-svelte-plugin' -- svelte plugin
   use {
      'evanleck/vim-svelte', branch = 'main',
      requires = { 'othree/html5.vim', 'pangloss/vim-javascript' }
   }
      
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
   use "folke/lsp-colors.nvim"
   use "navarasu/onedark.nvim"
   --use "EdenEast/nightfox.nvim"
   --use "sainnhe/sonokai"
   --use "folke/tokyonight.nvim"
   --use "haishanh/night-owl.vim"
   --use 'rmehri01/onenord.nvim'
   --use "rafamadriz/neon"
   --use 'JoosepAlviste/palenightfall.nvim'
end)
