-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'


  -- Impatient: speed up loading lua modules in neovim
  -- to improve startup time
  use 'lewis6991/impatient.nvim'


  -- Colorscheme tender
  use 'jacoborus/tender.vim'
  -- Colorscheme tokyonight
  use 'folke/tokyonight.nvim'


  -- Dev Icons (nvim)
  use 'kyazdani42/nvim-web-devicons'
  -- File explorer - nvim-tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  -- Lualine (statusline)
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  -- Luatab
  use {
    'alvarosevilla95/luatab.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }


  -- Comments
  use 'numToStr/Comment.nvim'


  -- Telesecope (Extendable fuzzy finder)
  use {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.0',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  -- FZF extension - telescope
  use {
    'nvim-telescope/telescope-fzf-native.nvim', 
    run = 'make clean && make'
  }


  -- Treesitter
  use {
    { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
    { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
    { 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' }
  }


  -- A Completion Engine plugin with
  -- Native LSP Configuration plugin
  use {
    { 
      -- completion engine
      'hrsh7th/nvim-cmp',
      requires = { 
        -- native LSP configuration plugin
        { 'neovim/nvim-lspconfig' },
        -- Snippet engine
        { 'L3MON4D3/LuaSnip' }
      }
    },
    -- nvim-cmp source for native LSP client
    { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
    -- nvim-cmp source for neovim lua API
    { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
    -- nvim-cmp source for buffer words
    { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
    -- nvim-cmp source for filesystem paths
    { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    -- nvim-cmp source for luasnip
    { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
    -- adds vscode-like pictograms to native LSP
    { 'onsails/lspkind-nvim', after = 'nvim-cmp' },
  }
  
  -- Language Servers
  --
  -- Goalng
  use { 'fatih/vim-go', run = ':GoUpdateBinaries' }
end)
