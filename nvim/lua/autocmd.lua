local au = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- don't put comments on newlines on `o`. autocommand because ftplugins overwrite this
-- au("BufEnter", { callback = function() vim.opt.formatoptions:remove({ "o" }) end })
au("FileType", { callback = function() vim.opt.formatoptions:remove({ "o" }) end })

au("InsertEnter", { command = "set cursorline" })
au("InsertLeave", { command = "set nocursorline" })

-- persist folds
au(
	{ "BufWinLeave", "BufLeave", "BufWritePost", "BufHidden", "QuitPre" },
	{ pattern = "?*", command = "silent! mkview!" } -- add nested?
)
au(
	"BufWinEnter",
	{ pattern = "?*", command = "silent! loadview" }
)

-- au("BufWritePost", {
-- 	pattern = "plugins.lua",
-- 	command = "source <afile> | PackerSync"
-- })

-- put help window to the left and make it narrow
au("BufEnter", { command = "if &ft ==# 'help' | wincmd L | vert resize 84 | endif" })

-- au("FocusLost", { command = "set mouse=" })
-- au("FocusGained", { command = "set mouse+=a" })

-- au("BufEnter", {
--   pattern = "init.lua",
--   callback = function()
--     vim.opt_local.foldmethod = "marker";
--   end,
-- })

