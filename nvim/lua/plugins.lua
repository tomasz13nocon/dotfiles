vim.g.ale_completion_enabled = 1

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

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

  use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = { 
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }

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

  if packer_bootstrap then
    require('packer').sync()
  end
end)
