local telescope = require('telescope')
local actions = require('telescope.actions')
telescope.setup {
  defaults = {
    -- preview = {
    --   treesitter = false,
    -- },
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
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
    },
    file_ignore_patterns = {
      "wtf_wikipedia/",
    },
  },
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
      }
    }
  },
}

telescope.load_extension("ui-select")
