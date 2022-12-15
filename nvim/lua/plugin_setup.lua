require'nvim-treesitter'.setup()
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = { enable = true },
  indent = { enable = true },
  context_commentstring = { -- jsx comments
    enable = true,
    enable_autocmd = false,
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
      }
    }
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

vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1D1E21 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#17171A gui=nocombine]]
require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
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

vim.g.popui_border_style = "rounded"
vim.ui.select = require"popui.ui-overrider"
vim.ui.input = require"popui.input-overrider"
vim.api.nvim_set_keymap("n", ",d", ':lua require"popui.diagnostics-navigator"()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", ",m", ':lua require"popui.marks-manager"()<CR>', { noremap = true, silent = true })

