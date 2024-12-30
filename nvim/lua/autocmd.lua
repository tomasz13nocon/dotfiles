local au = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup


-- don't put comments on newlines on `o`. autocommand because ftplugins overwrite this
-- au("BufEnter", { callback = function() vim.opt.formatoptions:remove({ "o" }) end })
au("FileType", { callback = function() vim.opt.formatoptions:remove({ "o" }) end })

au("InsertEnter", { command = "set cursorline" })
au("InsertLeave", { command = "set nocursorline" })

-- au("BufWritePre", { pattern = "*.js", callback = function() vim.lsp.buf.format() end })

local function try_format()
  vim.cmd([[ undojoin | lua vim.lsp.buf.format() ]])
end

local function pause_undo_and_format()
  if pcall(try_format) then
    --
  else
    vim.lsp.buf.format()
  end
end

au("BufWritePre", { pattern = "*.rs", callback = pause_undo_and_format })

au("FileType", {
  pattern = "qf,help,man,lspinfo",
  callback = function()
    vim.keymap.set("n", "q", ":close<CR>", { buffer = true })
  end
})
au("TextYankPost", {
  callback = function()
    require('vim.highlight').on_yank({ higroup = 'WildMenu', timeout = 300 })
  end
})

-- persist folds
-- THIS WAS THE ONE CHANGING MY CWD ALL THE TIME!!!
-- au(
--   { "BufWinLeave", "BufLeave", "BufWritePost", "BufHidden", "QuitPre" },
--   { pattern = "?*", command = "silent! mkview!" } -- add nested?
-- )
-- au(
--   "BufWinEnter",
--   { pattern = "?*", command = "silent! loadview" }
-- )

-- au("BufWritePost", {
--  pattern = "plugins.lua",
--  command = "source <afile> | PackerSync"
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

-- Show diagnostics in a pop-up window on hover
_G.LspDiagnosticsPopupHandler = function()
  local current_cursor = vim.api.nvim_win_get_cursor(0)
  local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or { nil, nil }
  if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
    vim.w.lsp_diagnostics_last_cursor = current_cursor
    vim.diagnostic.open_float(0, { scope = "cursor" })
  end
end
-- CursorMoved or CursorHold
vim.cmd [[
augroup LSPDiagnosticsOnHover
  autocmd!
  autocmd CursorMoved *   lua _G.LspDiagnosticsPopupHandler()
augroup END
]]


-- CONCEAL
-- local namespace = vim.api.nvim_create_namespace("class_conceal")
-- local group = vim.api.nvim_create_augroup("class_conceal", { clear = true })
--
-- local conceal_html_class = function(bufnr)
--     local language_tree = vim.treesitter.get_parser(bufnr, "html")
--     local syntax_tree = language_tree:parse()
--     local root = syntax_tree[1]:root()
--
--     local query = vim.treesitter.query.parse(
--         "html",
--         [[
--     ((attribute
--         (attribute_name) @att_name (#match? @att_name "class|className")
--         (quoted_attribute_value (attribute_value) @class_value) (#set! @class_value conceal "…")))
--     ]]
--     ) -- using single character for conceal thanks to u/Rafat913
--
--     for _, captures, metadata in query:iter_matches(root, bufnr, root:start(), root:end_()) do
--         local start_row, start_col, end_row, end_col = captures[2]:range()
--         vim.api.nvim_buf_set_extmark(bufnr, namespace, start_row, start_col, {
--             end_line = end_row,
--             end_col = end_col,
--             conceal = metadata[2].conceal,
--         })
--     end
-- end
--
-- au({ "BufEnter", "BufWritePost", "TextChanged", "InsertLeave" }, {
--     group = group,
--     pattern = "*.html,*.svelte,*.jsx,*.tsx",
--     callback = function()
--         conceal_html_class(vim.api.nvim_get_current_buf())
--     end,
-- })
