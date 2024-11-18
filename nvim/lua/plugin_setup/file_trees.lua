-- nvim-tree.lua
require("nvim-tree").setup {
  -- disable_netrw = true,
  filters = {
    -- dotfiles = true,
  },
  view = {
    width = 32,
  },
  update_focused_file = { enable = true, update_cwd = false },
  diagnostics = {
    enable = true,
  }
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

-- rnvimr
vim.g.rnvimr_enable_ex = 1
vim.g.rnvimr_enable_picker = 1

-- ranger.vim
-- vim.g.ranger_map_keys = 0
-- vim.g.ranger_replace_netrw = 1
