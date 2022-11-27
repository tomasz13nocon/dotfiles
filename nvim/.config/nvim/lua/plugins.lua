vim.g.ale_completion_enabled = 1

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  --	Color schemes --
  use 'folke/tokyonight.nvim'
  use 'Shatur/neovim-ayu'
  --------------------
  -- use 'junegunn/fzf'
  -- use 'junegunn/fzf.vim'
  use 'numToStr/Comment.nvim'
  --	use 'JoosepAlviste/nvim-ts-context-commentstring' -- jsx comments
  use 'sheerun/vim-polyglot'
  use 'SirVer/ultisnips'
  use 'rmagatti/auto-session'
  use 'lewis6991/impatient.nvim'
  use 'neovim/nvim-lspconfig'

  -- Completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'quangnguyen30192/cmp-nvim-ultisnips'
  use 'aca/emmet-ls'

  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'nvim-telescope/telescope.nvim', -- TODO setup native sorter, see README
    requires = { {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } }
  }
  use 'dense-analysis/ale'
--	use 'ms-jpq/coq_nvim'
end)
