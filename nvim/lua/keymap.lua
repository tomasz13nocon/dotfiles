local map = vim.keymap.set
vim.g.mapleader = ' '
map('',  '<Space>',    '<Nop>')

local builtin = require('telescope.builtin')
local fzf_lua = require('fzf-lua')
local gs = require('gitsigns')

--------- INSERT ----------
map('i', '<C-L>',       '<cmd>:lua vim.lsp.buf.signature_help()<CR>')

--------- NORMAL ----------
-- empty string mappings work like :map, so normal, visual, operator pending (e.g. after d in normal), select (useless, ignore)
-- BARE
map('n', 'j',           'gj')
map('',  'J',           '4j')
map('n', 'k',           'gk')
map('',  'K',           '4k')
map('',  '+',           '"+y')
map('n', '<F2>',        ':lua vim.lsp.buf.rename()<CR>')
map('n', '<CR>',        'ciw')
-- g
map('n', 'gr',          ':lua vim.lsp.buf.references()<CR>')
map('n', 'gd',          ':lua vim.lsp.buf.definition()<CR>')
map('n', 'gD',          ':lua vim.lsp.buf.declaration()<CR>')
map('n', 'gi',          ':lua vim.lsp.buf.implementation()<CR>')
map('n', 'gl',          ':lua vim.diagnostic.open_float()<CR>')
map('n', 'gR',          '<cmd>TroubleToggle lsp_references<cr>')
-- []
map('n', '[d',          ':lua vim.diagnostic.goto_prev()<CR>')
map('n', ']d',          ':lua vim.diagnostic.goto_next()<CR>')
map('n', ']t',          function() require("trouble").next({skip_groups = true, jump = true}) end)
map('n', '[t',          function() require("trouble").previous({skip_groups = true, jump = true}) end)
map('n', ']h',          function() if vim.wo.diff then return ']c' end vim.schedule(function() gs.next_hunk() end) return '<Ignore>' end, { expr = true })
map('n', '[h',          function() if vim.wo.diff then return '[c' end vim.schedule(function() gs.prev_hunk() end) return '<Ignore>' end, { expr = true })
-- CTRL
map('',  '<C-c>',       ':lua require("ts-node-action").node_action()<CR>')
map('',  '<C-h>',       ':BufferLineCyclePrev<CR>') -- :BufferPrevious<CR>
map('',  '<C-S-h>',     ':BufferLineMovePrev<CR>') -- :BufferMovePrevious<CR>
map('',  '<C-j>',       ':join<CR>')
map('n', '<C-K>',       ':lua vim.lsp.buf.hover()<CR>')
map('',  '<C-l>',       ':BufferLineCycleNext<CR>') -- :BufferNext<CR>
map('',  '<C-S-l>',     ':BufferLineMoveNext<CR>') -- :BufferMoveNext<CR>
map('n', '<C-n>',       ':NvimTreeFocus<CR>')
map('n', '<C-S-n>',     ':NvimTreeToggle<CR>')
map('',  '<C-S-o>',     fzf_lua.resume)
map('',  '<C-p>',       fzf_lua.files) -- builtin.find_files
map('',  '<C-S-p>',     fzf_lua.live_grep) -- builtin.live_grep
map('',  '<C-q>',       ':bd<CR>') -- :BufferClose<CR>
map('',  '<C-1>',       ':BufferLineGoToBuffer 1<CR>')
map('',  '<C-2>',       ':BufferLineGoToBuffer 2<CR>')
map('',  '<C-3>',       ':BufferLineGoToBuffer 3<CR>')
map('',  '<C-4>',       ':BufferLineGoToBuffer 4<CR>')
map('',  '<C-5>',       ':BufferLineGoToBuffer 5<CR>')
map('',  '<C-6>',       ':BufferLineGoToBuffer 6<CR>')
map('',  '<C-7>',       ':BufferLineGoToBuffer 7<CR>')
map('',  '<C-8>',       ':BufferLineGoToBuffer 8<CR>')
map('',  '<C-9>',       ':BufferLineGoToBuffer 9<CR>')
map('',  '<C-0>',       ':BufferLineGoToBuffer 10<CR>')
map('n', '<C-Up>',      ':resize +2<CR>')
map('n', '<C-Down>',    ':resize -2<CR>')
map('n', '<C-Left>',    ':vertical resize -2<CR>')
map('n', '<C-Right>',   ':vertical resize +2<CR>')
-- ALT
map('',  '<A-i>',       '<Plug>(expand_region_shrink)')
map('n', '<A-j>',       ':m .+1<CR>==')
map('n', '<A-k>',       ':m .-2<CR>==')
map('',  '<A-o>',       '<Plug>(expand_region_expand)')
map('n', '<A-x>',       ':CccPick<CR>')
-- LEADER
map('n', '<leader>a',   ':lua vim.lsp.buf.code_action()<CR>')
map('n', '<leader>b',   'gbc', { remap = true }) -- this should probably be a plug mapping
map('n', '<leader>c',   'gcc', { remap = true }) -- this should probably be a plug mapping
map('',  '<Leader>d',   '"_d')
map('',  '<Leader>D',   '"_D')
map('',  '<Leader>h',   ':nohlsearch<CR>')
map('',  '<Leader>r',   ':luafile %<CR>')
map('',  '<Leader>R',   ':luafile ~/.config/nvim/lua/plugins.lua<CR>:PackerSync<CR>')
map('',  '<Leader>s',   ':Vista!!<CR>')
map('n', '<leader>w',   ':w<CR>')
map('',  '<Leader>x',   '"_x')
map('',  '<Leader>X',   '"_X')
map('',  '<leader>=',   ':lua vim.lsp.buf.format()<CR>')
-- f
map('n', '<leader>fh',  builtin.help_tags) --'<cmd>Telescope help_tags<cr>')
map('n', '<leader>fc',  builtin.colorscheme)
map('n', '<leader>fr',  builtin.lsp_references)
map('n', '<leader>fs',  builtin.treesitter)
map('n', '<leader>fl',  builtin.diagnostics)
-- g
map('n', '<leader>gc',  builtin.git_bcommits)
map('n', '<leader>gb',  builtin.git_branches)
map('n', '<leader>gs',  builtin.git_status)
map('n', '<leader>gt',  builtin.git_stash)
-- j
map('',  '<leader>ja',  ':Gitsigns stage_hunk<CR>')
map('',  '<leader>jr',  ':Gitsigns reset_hunk<CR>')
map('n', '<leader>jS',  gs.stage_buffer)
map('n', '<leader>ju',  gs.undo_stage_hunk)
map('n', '<leader>jR',  gs.reset_buffer)
map('n', '<leader>jp',  gs.preview_hunk)
map('n', '<leader>jb',  function() gs.blame_line { full = true } end)
map('n', '<leader>jtb', gs.toggle_current_line_blame)
map('n', '<leader>jd',  gs.diffthis)
map('n', '<leader>jD',  function() gs.diffthis('~') end)
map('n', '<leader>jtd', gs.toggle_deleted)
-- n
map('n', '<leader>nd',  '<cmd>lua require("package-info").delete()<cr>', { silent = true, noremap = true })
map('n', '<leader>nj',  ':lua require("ts-node-action").node_action<CR>')
map('n', '<leader>ns',  '<cmd>lua require("package-info").show()<cr>', { silent = true, noremap = true })
map('n', '<leader>nu',  '<cmd>lua require("package-info").change_version()<cr>', { silent = true, noremap = true })
-- t
map('n', '<leader>tt',  '<cmd>TroubleToggle<cr>')
map('n', '<leader>tw',  '<cmd>TroubleToggle workspace_diagnostics<cr>')
map('n', '<leader>td',  '<cmd>TroubleToggle document_diagnostics<cr>')
map('n', '<leader>tl',  '<cmd>TroubleToggle loclist<cr>')
map('n', '<leader>tq',  '<cmd>TroubleToggle quickfix<cr>')
-- map('n', '<Leader>fs', builtin.lsp_document_symbols)
-- map('n', '<Leader>fa', builtin.lsp_code_actions)
-- map('n', '<leader>gs', ':Neotree git_status<CR>')
-- map('n', '<Tab>',      ':lua require("ufo").peekFoldedLinesUnderCursor()<CR>')
-- map('n', '<C-n>',      ':Ranger<CR>')
-- map('n', '<C-n>',      ':RnvimrToggle<CR>')
-- "<leader>qf" vim.diagnostic.setqflist
-- "<leader>q"  vim.diagnostic.setloclist
-- "<leader>fS" vim.lsp.buf.workspace_symbol
-- map('', '<leader>fs', ':lua vim.lsp.buf.document_symbol()<CR>')
-- map('',  '<C-q>',      ':bp<bar>sp<bar>bn<bar>bd<CR>')
-- map('',  '<C-s>',      '<cmd>:w<CR>')
-- map('n', 'zR',          require('ufo').openAllFolds)
-- map('n', 'zM',          require('ufo').closeAllFolds)

--------- VISUAL ---------- 
-- BARE
map('v', 'p',           '"_dP')
map('v', 'Q',           ':norm @q<cr>')
map('v', '@',           ":'<,'>normal @q<CR>")
map('v', '<',           '<gv')
map('v', '>',           '>gv')
-- CTRL
-- ALT
map('v', '<A-j>',       ":m '>+1<CR>gv=gv")
map('v', '<A-k>',       ":m '<-2<CR>gv=gv")
-- LEADER
map('v', '<Leader>b',   'gb', { remap = true }) -- this should probably be a plug mapping
map('v', '<Leader>c',   'gc', { remap = true }) -- this should probably be a plug mapping
map('v', '<Leader>w',   '<Esc>:w<CR>')

------- Text object -------
map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
