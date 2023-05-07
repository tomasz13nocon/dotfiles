vim.cmd [[highlight IndentBlanklineIndent1 guibg=#232529 gui=nocombine]]
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
