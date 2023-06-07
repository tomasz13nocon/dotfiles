require 'plugin_setup.cmp'
require 'plugin_setup.file_trees'
-- require 'plugin_setup.foldhue'
require 'plugin_setup.gitsigns'
require 'plugin_setup.indent_blankline'
require 'plugin_setup.lsp'
-- require 'plugin_setup.lsp_inlayhints'
require 'plugin_setup.lualine'
-- require 'plugin_setup.navic'
require 'plugin_setup.neodim'
require 'plugin_setup.package_info'
require 'plugin_setup.telescope'
require 'plugin_setup.treesitter'
-- require 'plugin_setup.ufo'
require 'plugin_setup.ultisnips'


-- require'symbols-outline'.setup() -- symbols-outline.nvim
-- require'nvim-autopairs'.setup{}
require 'various-textobjs'.setup { useDefaultKeymaps = true } -- nvim-various-textobjs
require 'ccc'.setup { highlighter = { auto_enable = true } }
require 'treesitter-context'.setup {}
require 'nvim-surround'.setup {}
require 'ts-node-action'.setup {}
require 'which-key'.setup {}
require 'trouble'.setup {}
require 'aerial'.setup()
require("oil").setup {}
require('bamboo').setup {}
require('bamboo').load()

-- numToStr/Comment.nvim
require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(), -- jsx comments
}

require("auto-session").setup {
  log_level = "error",
  -- auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
}

require('fzf-lua').setup {
  files = {
    fd_opts = "--exclude node_modules --type f",
  }
}

-- require 'bufferline'.setup { -- barbar.nvim
--   animation = false,
--   highlight_inactive_file_icons = true,
-- }
require 'bufferline'.setup {
  options = {
    -- diagnostics = "nvim_lsp",
    sort_by = "insert_after_current"
  }
}

vim.g.vista_default_executive = 'nvim_lsp'

-- HLs not working
-- vim.api.nvim_set_hl(0, "BufferCurrent", { default = true, bg = "#444444" })
-- vim.api.nvim_set_hl(0, "BufferCurrentSign", { default = true, bg = "#444444" })
-- vim.api.nvim_set_hl(0, "BufferCurrentIcon", { default = true, bg = "#444444" })

-- popui.nvim
-- vim.g.popui_border_style = "rounded"
-- vim.ui.select = require "popui.ui-overrider"
-- vim.ui.input = require "popui.input-overrider"
-- vim.api.nvim_set_keymap("n", ",d", ':lua require"popui.diagnostics-navigator"()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", ",m", ':lua require"popui.marks-manager"()<CR>', { noremap = true, silent = true })

-- vim-illuminate
vim.cmd [[highlight def IlluminatedWordText  guibg=#3e3e46 gui=NONE]]
vim.cmd [[highlight def IlluminatedWordRead  guibg=#3e3e46 gui=NONE]]
vim.cmd [[highlight def IlluminatedWordWrite guibg=#3e3e46 gui=NONE]]

-- require'nvim_context_vt'.setup{}

-- copilot
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
