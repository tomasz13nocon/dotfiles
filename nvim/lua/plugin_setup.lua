require'nvim-treesitter'.setup()
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = { enable = true },
  indent = { enable = true },
  context_commentstring = { -- jsx comments
    enable = true,
    enable_autocmd = false,
  },
  autotag = { -- auto close and rename html tags
    enable = true,
  },
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "gnn",
  --     node_incremental = "grn",
  --     scope_incremental = "grc",
  --     node_decremental = "grm",
  --   },
  -- },
  -- rainbow = {
  --   enable = true,
  --   -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
  --   extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  --   max_file_lines = nil, -- Do not enable for files with more than n lines, int
  --   -- colors = {}, -- table of hex strings
  --   -- termcolors = {} -- table of colour name strings
  -- }
}

local telescope = require('telescope')
local actions = require('telescope.actions')
telescope.setup{
  defaults = {
    mappings = {
      i = {
        ["<Esc>"] = "close",
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
        ["<C-u>"] = false,
        ["<C-f>"] = "preview_scrolling_down",
        ["<C-b>"] = "preview_scrolling_up",
        ["Down"] = actions.cycle_history_next,
        ["Up"] = actions.cycle_history_prev,
      }
    },
    file_ignore_patterns = {
      "wtf_wikipedia/",
    },
    history = {
      path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
      limit = 100,
    },
  },
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  },
  -- extensions = {
  --   ["ui-select"] = {
  --     require("telescope.themes").get_dropdown {
  --     }
  --   }
  -- },
}
-- telescope.load_extension("ui-select")
telescope.load_extension("smart_history")


require'lualine'.setup{
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'},
  }
}

-- numToStr/Comment.nvim
require('Comment').setup{
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(), -- jsx comments
}

require("auto-session").setup{
  log_level = "error",
  -- auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
}

-- nvim-tree.lua
require("nvim-tree").setup{
  filters = {
    dotfiles = true,
  },
  view = {
    width = 32,
  },
}

-- nvim-neo-tree/neo-tree.nvim
-- vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
-- require("neo-tree").setup{
--   window = {
--     mappings = {
--       ['h'] = "close_node",
--       ['l'] = "open",
--     }
--   },
--   filesystem = {
--     follow_current_file = true,
--   },
--   git_status = {
--     window = {
--       position = "float",
--       mappings = {
--         ["A"]  = "git_add_all",
--         ["gu"] = "git_unstage_file",
--         ["ga"] = "git_add_file",
--         ["gr"] = "git_revert_file",
--         ["gc"] = "git_commit",
--         ["gp"] = "git_push",
--         ["gg"] = "git_commit_and_push",
--       }
--     }
--   },
-- }

-- ultisnips
vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
vim.g.UltiSnipsRemoveSelectModeMappings = 0

-- popui.nvim
vim.g.popui_border_style = "rounded"
vim.ui.select = require"popui.ui-overrider"
vim.ui.input = require"popui.input-overrider"
vim.api.nvim_set_keymap("n", ",d", ':lua require"popui.diagnostics-navigator"()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", ",m", ':lua require"popui.marks-manager"()<CR>', { noremap = true, silent = true })

require("neodim").setup{
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
}

require('gitsigns').setup{
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  }
}

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

vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1D1E21 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#17171A gui=nocombine]]
require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = false,
    char = "",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
    space_char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
    show_trailing_blankline_indent = false,
}

vim.cmd [[highlight def IlluminatedWordText  guibg=#3e3e46 gui=NONE]]
vim.cmd [[highlight def IlluminatedWordRead  guibg=#3e3e46 gui=NONE]]
vim.cmd [[highlight def IlluminatedWordWrite guibg=#3e3e46 gui=NONE]]


----- Simple setup -----
require'treesitter-context'.setup{}
require'bufferline'.setup() -- barbar.nvim
require'symbols-outline'.setup() -- symbols-outline.nvim
require'which-key'.setup{}
require'nvim-surround'.setup{}
require'various-textobjs'.setup{ useDefaultKeymaps = true } -- nvim-various-textobjs
require'ccc'.setup{ highlighter = { auto_enable = true } }
require'lsp_lines'.setup()
require'trouble'.setup{}
require'nvim_context_vt'.setup{}
-- require'nvim-autopairs'.setup{}
----- Simple setup -----
