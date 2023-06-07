vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

local packer = require('packer')

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-- packer in floating window
-- packer.init {
--   display = {
--     open_fn = function()
--       return require('packer.util').float { border = 'rounded' }
--     end,
--   },
-- }

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-tree/nvim-web-devicons'

  -------- Color schemes ---------
  use 'LunarVim/Colorschemes'
  use 'Shatur/neovim-ayu'
  use 'folke/tokyonight.nvim'
  use 'wbinnssmith/base16-oceanic-next'
  use 'drewtempelmeyer/palenight.vim'
  use 'rebelot/kanagawa.nvim'
  use 'sainnhe/edge'
  use 'sainnhe/everforest'
  use 'rose-pine/neovim'
  use 'embark-theme/vim'
  use 'daschw/leaf.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'glepnir/zephyr-nvim'
  use 'romgrk/doom-one.vim'
  use 'ribru17/bamboo.nvim'
  -- use 'rafi/awesome-vim-colorschemes'
  -- use 'romgrk/doom-one.vim'
  -- use 'lukas-reineke/onedark.nvim'
  -- use 'mkarmona/colorsbox'
  -- use 'NLKNguyen/papercolor-theme'
  -- use 'jacoborus/tender.vim'
  -- use 'catppuccin/nvim'
  --------------------------------

  ------- Language support -------
  use 'sheerun/vim-polyglot'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'windwp/nvim-ts-autotag'
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'JoosepAlviste/nvim-ts-context-commentstring' -- jsx comments
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'jose-elias-alvarez/typescript.nvim'
  -- use 'lvimuser/lsp-inlayhints.nvim'
  use 'chikamichi/mediawiki.vim'
  use 'prisma/vim-prisma'
  --------------------------------

  ---------- Completion ----------
  use 'SirVer/ultisnips'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'quangnguyen30192/cmp-nvim-ultisnips'
  use 'hrsh7th/cmp-nvim-lsp-document-symbol'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  -- use 'mattn/emmet-vim' -- used by cmp-emmet-vim
  -- use 'dcampos/cmp-emmet-vim'
  -- use({
  --   'jackieaskins/cmp-emmet',
  --   run = 'npm run release'
  -- })
  -- use 'arafatamim/emmet-ls'
  use 'onsails/lspkind.nvim'
  use 'folke/neodev.nvim'
  use 'b0o/schemastore.nvim'
  use 'github/copilot.vim'
  -- use "zbirenbaum/copilot.lua"
  -- use "zbirenbaum/copilot-cmp"
  --------------------------------

  --------- UI / Visual ----------
  use 'liuchengxu/vista.vim' -- alt: simrat39/symbols-outline.nvim
  use 'stevearc/aerial.nvim'
  -- use 'romgrk/barbar.nvim'
  use { 'akinsho/bufferline.nvim', tag = "*" }
  use 'nvim-lualine/lualine.nvim'
  use 'hood/popui.nvim' -- alt: stevearc/dressing.nvim
  use 'dstein64/nvim-scrollview'
  use 'RRethy/vim-illuminate'
  use 'KabbAmine/vCoolor.vim'
  -- use 'shmargum/vim-sass-colors' -- This one might be the cause of the telescope errors
  use {
    'zbirenbaum/neodim',
    event = 'LspAttach',
  }
  use 'lukas-reineke/indent-blankline.nvim' -- makes 'leafOfTree/vim-matchtag' obsolete
  -- use 'haringsrob/nvim_context_vt'
  -- use 'SmiteshP/nvim-navic'
  --------------------------------

  --------- File trees -----------
  use { 'nvim-tree/nvim-tree.lua', tag = 'nightly' }
  -- use 'rbgrouleff/bclose.vim'
  -- use 'francoiscabrol/ranger.vim'
  use 'kevinhwang91/rnvimr'
  -- use 'ipod825/ranger.nvim'
  use 'stevearc/oil.nvim'
  --------------------------------

  ------------ Other -------------
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } }
  }
  use 'ibhagwan/fzf-lua'
  use 'lewis6991/impatient.nvim'
  use 'numToStr/Comment.nvim'
  use 'rmagatti/auto-session'
  use 'chrisgrieser/nvim-various-textobjs'
  use 'AndrewRadev/splitjoin.vim'
  use 'uga-rosa/ccc.nvim'
  use 'tomasz13nocon/vim-closer' -- better than 'windwp/nvim-autopairs'
  use { 'kylechui/nvim-surround', tag = '*' }
  use 'lewis6991/gitsigns.nvim'
  use 'sindrets/diffview.nvim'
  use 'milisims/foldhue.nvim'
  use 'folke/which-key.nvim'
  use 'dkarter/bullets.vim'
  use 'tommcdo/vim-exchange'
  -- use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}
  use 'folke/trouble.nvim'
  use 'terryma/vim-expand-region'
  use({
    "vuki656/package-info.nvim",
    requires = "MunifTanjim/nui.nvim",
  })
  use 'ckolkey/ts-node-action'
  --------------------------------

  if packer_bootstrap then
    require('packer').sync()
  end
end)
