vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])


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

local packer = require('packer')

-- packer in floating window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

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
  use { 'catppuccin/nvim', as = 'catppuccin' }
  use 'projekt0n/github-nvim-theme'
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
  -- use 'nvim-treesitter/nvim-treesitter-context'
  use 'JoosepAlviste/nvim-ts-context-commentstring' -- jsx comments
  use 'nvimtools/none-ls.nvim'
  use 'nvimtools/none-ls-extras.nvim'
  -- use 'jose-elias-alvarez/typescript.nvim'
  -- use 'lvimuser/lsp-inlayhints.nvim'
  use 'chikamichi/mediawiki.vim'
  use 'prisma/vim-prisma'
  use 'elkowar/yuck.vim'
  use 'Hoffs/omnisharp-extended-lsp.nvim'
  -- use 'mrcjkb/rustaceanvim'
  use 'stevearc/conform.nvim'
  --------------------------------

  ---------- Completion ----------
  use 'SirVer/ultisnips'
  use {
    "L3MON4D3/LuaSnip",
    tag = "v2.*",
    run = "make install_jsregexp"
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'quangnguyen30192/cmp-nvim-ultisnips'
  use 'hrsh7th/cmp-nvim-lsp-document-symbol'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use {
    'saghen/blink.cmp',
    tag = "v1.0.0",
  }
  use 'Saghen/blink.compat'
  use 'Issafalcon/lsp-overloads.nvim'
  -- use 'mattn/emmet-vim' -- used by cmp-emmet-vim
  -- use 'dcampos/cmp-emmet-vim'
  -- use({
  --   'jackieaskins/cmp-emmet',
  --   run = 'npm run release'
  -- })
  -- use 'arafatamim/emmet-ls'
  use 'onsails/lspkind.nvim'
  -- use 'folke/lazydev.nvim'
  use 'b0o/schemastore.nvim'
  -- use 'github/copilot.vim'
  -- use "zbirenbaum/copilot.lua"
  -- use "zbirenbaum/copilot-cmp"
  --------------------------------

  ------------- LSP --------------
  use 'artemave/workspace-diagnostics.nvim'
  use 'j-hui/fidget.nvim'
  --------------------------------

  --------- UI / Visual ----------
  use 'liuchengxu/vista.vim' -- alt: simrat39/symbols-outline.nvim
  use 'stevearc/aerial.nvim'
  -- use 'romgrk/barbar.nvim'
  use { 'akinsho/bufferline.nvim', tag = "*" }
  use 'nvim-lualine/lualine.nvim'
  use 'hood/popui.nvim'       -- alt: stevearc/dressing.nvim
  use 'dstein64/nvim-scrollview'
  use 'RRethy/vim-illuminate' -- automatically highlighting other uses of the word under the cursor
  use 'KabbAmine/vCoolor.vim' -- color picker
  -- use 'shmargum/vim-sass-colors' -- This one might be the cause of the telescope errors
  --  use {
  --    'zbirenbaum/neodim',
  --    event = 'LspAttach',
  --  }
  use 'lukas-reineke/indent-blankline.nvim' -- makes 'leafOfTree/vim-matchtag' obsolete
  -- use 'rcarriga/nvim-notify'
  -- use 'haringsrob/nvim_context_vt'
  use 'nvim-telescope/telescope-ui-select.nvim'
  -- use { "anuvyklack/windows.nvim",
  --  requires = {
  --     "anuvyklack/middleclass",
  --     "anuvyklack/animation.nvim"
  --  },
  --  config = function()
  --     vim.o.winwidth = 10
  --     vim.o.winminwidth = 10
  --     vim.o.equalalways = false
  --     require('windows').setup({
  --       animation = {
  --         duration = 100,
  --         fps = 60,
  --       }
  --     })
  --  end
  -- }
  --------------------------------

  --------- File trees -----------
  use { 'nvim-tree/nvim-tree.lua' }
  -- use 'rbgrouleff/bclose.vim'
  -- use 'francoiscabrol/ranger.vim'
  -- use 'kevinhwang91/rnvimr'
  -- use 'ipod825/ranger.nvim'
  -- use 'stevearc/oil.nvim'
  --------------------------------

  ------------ Other -------------
  -- use 'famiu/bufdelete.nvim'
  -- use 'moll/vim-bbye'
  use 'ojroques/nvim-bufdel'
  use 'echasnovski/mini.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } }
  }
  use 'tpope/vim-abolish'
  use 'ibhagwan/fzf-lua'
  use 'lewis6991/impatient.nvim'
  use 'numToStr/Comment.nvim'
  use 'rmagatti/auto-session'
  use 'chrisgrieser/nvim-various-textobjs'
  use 'AndrewRadev/splitjoin.vim'
  use {
    'uga-rosa/ccc.nvim',
    tag = "v1.7.2", -- 2.0 be buggy af
  }
  -- use 'tomasz13nocon/vim-closer' -- better than 'windwp/nvim-autopairs'
  -- use 'm4xshen/autoclose.nvim' -- stupid
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end
  }
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
  use 'antosha417/nvim-lsp-file-operations' -- must go after nvim-tree
  use({
    'iamcco/markdown-preview.nvim',
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  })
  use 'mizlan/iswap.nvim'
  --------------------------------

  if packer_bootstrap then
    require('packer').sync()
  end
end)

