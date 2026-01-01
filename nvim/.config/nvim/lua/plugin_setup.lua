require 'plugin_setup.indent_blankline'
require 'plugin_setup.package_info'
require 'plugin_setup.file_trees'
require 'plugin_setup.treesitter'
require 'plugin_setup.telescope'
require 'plugin_setup.ultisnips'
require 'plugin_setup.gitsigns'
require 'plugin_setup.lualine'
require 'plugin_setup.conform'
require 'plugin_setup.blink'
-- require 'plugin_setup.cmp'
require 'plugin_setup.lsp'
-- require 'plugin_setup.foldhue'
-- require 'plugin_setup.lsp_inlayhints'
-- require 'plugin_setup.navic'
-- require 'plugin_setup.neodim'
-- require 'plugin_setup.ufo'


require 'various-textobjs'.setup{ keymaps = { useDefaults = true } } -- nvim-various-textobjs
require 'ccc'.setup{ highlighter = { auto_enable = true } }
require 'luasnip.loaders.from_vscode'.lazy_load({ paths = { "./snippets" } })
require 'lsp-file-operations'.setup()
require("cmp_nvim_ultisnips").setup{}
-- require 'treesitter-context'.setup{}
require 'nvim-ts-autotag'.setup{}
require 'ts-node-action'.setup{}
require 'nvim-surround'.setup{}
require 'which-key'.setup{}
require 'trouble'.setup{}
-- require 'lazydev'.setup{} -- I think this needs lazy.nvim to work...?
require 'fidget'.setup{}
require 'aerial'.setup()
-- require 'oil'.setup{}
-- require'symbols-outline'.setup() -- symbols-outline.nvim
-- require'nvim-autopairs'.setup{}
-- require('bamboo').setup {}
-- require('bamboo').load()

require("diffview").setup({
  view = {
    merge_tool = {
      layout = "diff3_mixed",
    }
  }
})

require('bufdel').setup {
  next = 'alternate',
  quit = false,  -- quit Neovim when last buffer is closed
}

require 'Comment'.setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

require("auto-session").setup {
  -- log_level = "error",
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
    -- offsets = {
    --   { filetype = "NvimTree" }
    -- },
    diagnostics = "nvim_lsp",
    sort_by = "insert_after_current",
    show_buffer_close_icons = false,
    -- separator_style = "slant",
    -- show_tab_indicators = true,
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
