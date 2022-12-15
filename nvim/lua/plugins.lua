vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

local packer = require('packer')

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

-- packer in floating window
-- packer.init {
--   display = {
--     open_fn = function()
--       return require("packer.util").float { border = "rounded" }
--     end,
--   },
-- }

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  --	Color schemes --
  use 'LunarVim/Colorschemes'
  -- use 'rafi/awesome-vim-colorschemes'
  use 'Shatur/neovim-ayu'
  use 'folke/tokyonight.nvim'
  use 'wbinnssmith/base16-oceanic-next'
  use 'drewtempelmeyer/palenight.vim'
  -- use 'romgrk/doom-one.vim'
  -- use 'lukas-reineke/onedark.nvim'
  -- use 'mkarmona/colorsbox'
  -- use 'NLKNguyen/papercolor-theme'
  -- use 'jacoborus/tender.vim'
  -- use 'catppuccin/nvim'
  --------------------
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup{
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(), -- jsx comments
      }
    end
  }
  use 'JoosepAlviste/nvim-ts-context-commentstring' -- jsx comments
  use {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        -- auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
      }
    end
  }
  use 'lewis6991/impatient.nvim'
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function ()
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
      require("neo-tree").setup{
        window = {
          mappings = {
            ['h'] = "close_node",
            ['l'] = "open",
          }
        },
        filesystem = {
          follow_current_file = true,
        },
        git_status = {
          window = {
            position = "float",
            mappings = {
              ["A"]  = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
            }
          }
        },
      }
    end,
  }
  use { 'simrat39/symbols-outline.nvim', config = function() require("symbols-outline").setup() end }
  use 'sheerun/vim-polyglot'
  use {'SirVer/ultisnips',
    config = function()
      vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
      vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
      vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
      vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
      vim.g.UltiSnipsRemoveSelectModeMappings = 0
    end
  }
  -- use 'VonHeikemen/lsp-zero.nvim'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  -- use 'p00f/nvim-ts-rainbow'
  -- use { 'nvim-treesitter/nvim-treesitter-context', config = function () require'treesitter-context'.setup{} end }
  use({
      "jose-elias-alvarez/null-ls.nvim",
      requires = { "nvim-lua/plenary.nvim" },
    })

  -- Completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'quangnguyen30192/cmp-nvim-ultisnips'
  use 'hrsh7th/cmp-nvim-lsp-document-symbol'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'aca/emmet-ls'
  use 'onsails/lspkind.nvim'
  use "folke/neodev.nvim"
  use "b0o/schemastore.nvim"

  use 'hood/popui.nvim' -- alternative: stevearc/dressing.nvim
  use "lukas-reineke/indent-blankline.nvim"
  -- use 'leafOfTree/vim-matchtag' -- obsoleted by indent-blankline.nvim
  use 'RRethy/vim-illuminate'
  use 'dstein64/nvim-scrollview'
  -- use { 'NvChad/nvim-colorizer.lua', config = function() require'colorizer'.setup{ user_default_options = { css = true } } end }
  use 'KabbAmine/vCoolor.vim'
  use { 'uga-rosa/ccc.nvim', config = function() require'ccc'.setup{ highlighter = { auto_enable = true } } end }
  use {
    "zbirenbaum/neodim",
    event = "LspAttach",
    config = function ()
      require("neodim").setup({
          alpha = 0.65,
          blend_color = "#000000",
          update_in_insert = {
            enable = true,
            delay = 200,
          },
          hide = {
            virtual_text = true,
            signs = true,
            underline = true,
          }
        })
    end
  }
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function() require'bufferline'.setup() end
  }
  use {
    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } }
  }
  -- use {'nvim-telescope/telescope-ui-select.nvim' }
  -- use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require'lualine'.setup{} end
  }
  -- use {
  --   "windwp/nvim-autopairs",
  --   config = function() require("nvim-autopairs").setup {} end
  -- }
  use 'rstacruz/vim-closer'
  use {
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({ })
    end
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup{
        signs = {
          add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
          change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        }
      }
    end
  }
  use {
    'milisims/foldhue.nvim',
    config = function()
      require('foldhue').enable()
      require('foldhue').fade = function(hl)
        local rgb = string.format('%0X', hl.foreground)  -- octal to hex
        local r, g, b = rgb:sub(1, 2), rgb:sub(3, 4), rgb:sub(5, 6)
        local f = (1)
        -- hex to number, so we can do math:
        r, g, b = vim.fn.str2nr(r, 16) * f, vim.fn.str2nr(g, 16) * f, vim.fn.str2nr(b, 16) * f
        -- back to hex:
        hl.foreground = vim.fn.printf('#%x%x%x', math.floor(r + 0.5), math.floor(g + 0.5), math.floor(b + 0.5))
        return hl
      end
    end
  }
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  }
  use 'dkarter/bullets.vim'




  -- https://github.com/zhimsel/vim-stay

  if packer_bootstrap then
    require('packer').sync()
  end
end)
