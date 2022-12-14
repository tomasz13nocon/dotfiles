require'Comment'.setup()
require'nvim-treesitter'.setup()
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "lua", "css", "scss" },
  highlight = { enable = true },
  -- indent = { enable = true },
}
require('telescope').setup{
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  },
  defaults = {
    mappings = {
      i = {
        ["<Esc>"] = "close",
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      }
    }
  }
}
require'colorizer'.setup{ user_default_options = { css = true } }
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]
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
require'bufferline'.setup {
  maximum_length = 100,
}
local hl = require'bufferline.utils'.hl
hl.set_default_link('BufferVisibleIcon', 'BufferCurrent')
hl.set_default_link('BufferInactiveIcon', 'BufferCurrent')
hl.set_default_link('BufferDefaultCurrentIcon', 'BufferDefaultCurrent')
hl.set_default_link('BufferDefaultInactiveIcon', 'BufferDefaultCurrent')
hl.set_default_link('BufferDefaultVisibleIcon', 'BufferDefaultCurrent')
require('lualine').setup{}

-- vim.ui.select = require"popui.ui-overrider"
-- vim.ui.input = require"popui.input-overrider"
-- vim.api.nvim_set_keymap("n", ",d", ':lua require"popui.diagnostics-navigator"()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", ",m", ':lua require"popui.marks-manager"()<CR>', { noremap = true, silent = true })

