-- vim.cmd [[highlight IndentBlanklineIndent1 guibg=#232529 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guibg=#17171A gui=nocombine]]
local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

-- local hooks = require "ibl.hooks"
-- -- create the highlight groups in the highlight setup hook, so they are reset
-- -- every time the colorscheme changes
-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
--   -- vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
--   -- vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
--   -- vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
--   -- vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
--   -- vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
--   -- vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
--   -- vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
--   vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { fg = "#36373C" })
--   vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { fg = "#36373C" })
--   vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", { fg = "#3F4046" })
--   vim.api.nvim_set_hl(0, "IblScope", { fg = "#5A7451" })
-- end)

-- vim.api.nvim_set_hl(0, "IblScope", { fg = "#5A7451" })
vim.api.nvim_set_hl(0, "IblOne", { fg = "#2F3237" })
vim.api.nvim_set_hl(0, "IblTwo", { fg = "#454D58" })

require("ibl").setup {
  scope = {
    show_start = false,
    show_end = false,
  },
  indent = {
    highlight = {"IblOne", "IblTwo"},
    char = "▏"
  }
}
-- require("ibl").setup {
-- show_current_context = true,
-- show_current_context_start = false,
-- indent = {
--   char = "",
-- },
-- char_highlight_list = {
--   "IndentBlanklineIndent1",
--   "IndentBlanklineIndent2",
-- },
-- space_char_highlight_list = {
--   "IndentBlanklineIndent1",
--   "IndentBlanklineIndent2",
-- },
-- show_trailing_blankline_indent = false,
-- }
