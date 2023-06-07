require 'nvim-treesitter'.setup()
require 'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = { enable = true },
  indent = { enable = true },
  context_commentstring = {
    -- jsx comments
    enable = true,
    enable_autocmd = false,
  },
  autotag = { -- windwp/nvim-ts-autotag - auto close and rename html tags
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
