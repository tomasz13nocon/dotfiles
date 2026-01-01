local map = vim.keymap.set
vim.g.mapleader = ' '
map('',  '<Space>',    '<Nop>')

local builtin = require('telescope.builtin')
local fzf_lua = require('fzf-lua')
local gs = require('gitsigns')

--------- INSERT ----------
-- map('i', '<C-L>',       '<cmd>:lua vim.lsp.buf.signature_help()<CR>')

--------- NORMAL ----------
-- empty string mappings work like :map, so normal, visual, operator pending (e.g. after d in normal), select (useless, ignore)
-- BARE
map('n', 'j',           'gj')
map('',  'J',           '4j')
map('n', 'k',           'gk')
map('',  'K',           '4k')
map('',  '+',           '"+y')
map('n', '<F2>',        ':lua vim.lsp.buf.rename()<CR>')
-- map('n', '<CR>',        'ciw')
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
map('n', ']h',          function() if vim.wo.diff then return ']c' end vim.schedule(function() gs.nav_hunk("next") end) return '<Ignore>' end, { expr = true })
map('n', '[h',          function() if vim.wo.diff then return '[c' end vim.schedule(function() gs.nav_hunk("prev") end) return '<Ignore>' end, { expr = true })
-- CTRL
map('',  '<C-c>',       ':lua require("ts-node-action").node_action()<CR>')
map('',  '<C-S-d>',     ':Telescope diagnostics<CR>')
map('',  '<C-h>',       '<cmd>lua cycle_no_wrap("prev")<CR>') -- :BufferPrevious<CR> , :BufferLineCyclePrev<CR>
map('',  '<C-S-h>',     ':BufferLineMovePrev<CR>') -- :BufferMovePrevious<CR>
map('n', '<C-j>',       ':join<CR>')
map('n', '<C-K>',       ':lua vim.lsp.buf.hover()<CR>')
map('',  '<C-l>',       '<cmd>lua cycle_no_wrap("next")<CR>') -- :BufferNext<CR> , :BufferLineCycleNext<CR>
map('',  '<C-S-l>',     ':BufferLineMoveNext<CR>') -- :BufferMoveNext<CR>
map('n', '<C-n>',       ':NvimTreeFocus<CR>')
map('n', '<C-S-n>',     ':NvimTreeToggle<CR>')
map('',  '<C-S-o>',     fzf_lua.resume)
map('',  '<C-p>',       fzf_lua.files) -- builtin.find_files
map('',  '<C-S-p>',     fzf_lua.live_grep) -- builtin.live_grep
map('',  '<C-z>',       '<nop>')
map('',  '<C-q>',       '<cmd>lua delbuf()<CR>') -- :BufferClose<CR> , :bd<CR>:bp<CR> , :BufferLineCyclePrev<CR>:BufDel#<CR>
map('',  '<C-s>',      '<cmd>:w<CR>') -- ':ISwapWith<CR>'
map('',  '<C-1>',       '<cmd>lua require"bufferline".go_to(1, true)<CR>')
map('',  '<C-2>',       '<cmd>lua require"bufferline".go_to(2, true)<CR>')
map('',  '<C-3>',       '<cmd>lua require"bufferline".go_to(3, true)<CR>')
map('',  '<C-4>',       '<cmd>lua require"bufferline".go_to(4, true)<CR>')
map('',  '<C-5>',       '<cmd>lua require"bufferline".go_to(5, true)<CR>')
map('',  '<C-6>',       '<cmd>lua require"bufferline".go_to(6, true)<CR>')
map('',  '<C-7>',       '<cmd>lua require"bufferline".go_to(7, true)<CR>')
map('',  '<C-8>',       '<cmd>lua require"bufferline".go_to(8, true)<CR>')
map('',  '<C-9>',       '<cmd>lua require"bufferline".go_to(-1, true)<CR>')
map('n', '<C-/>',       'gcc', { remap = true }) -- this should probably be a plug mapping
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
map('n',  '<Leader>i',  ':lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({0}),{0})<CR>')
map('',  '<Leader>r',   ':luafile %<CR>')
map('',  '<Leader>R',   ':luafile ~/.config/nvim/lua/plugins.lua<CR>:PackerSync<CR>')
-- map('',  '<Leader>s',   ':Vista!!<CR>')
map('',  '<Leader>s',   ':AerialToggle<CR>')
map('n', '<leader>w',   ':w<CR>')
map('',  '<Leader>x',   '"_x')
map('',  '<Leader>X',   '"_X')
-- map('',  '<leader>=',   ':lua vim.lsp.buf.format()<CR>')
map('',  '<leader>=',   ':lua require"conform".format{ lsp_format = "fallback", undojoin = true, timeout_ms = 5000 }<CR>')
-- f
map('n', '<leader>fh',  builtin.help_tags) --'<cmd>Telescope help_tags<cr>')
map('n', '<leader>fc',  builtin.colorscheme)
map('n', '<leader>fr',  builtin.lsp_references)
map('n', '<leader>fs',  builtin.treesitter)
map('n', '<leader>fl',  builtin.diagnostics)
-- g
map('n', '<leader>gb',  builtin.git_branches)
map('n', '<leader>gc',  builtin.git_bcommits)
map('n', '<leader>gl',  fzf_lua.git_blame)
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
map('n', '<leader>nu',  '<cmd>lua require("package-info").update()<cr>', { silent = true, noremap = true })
map('n', '<leader>nv',  '<cmd>lua require("package-info").change_version()<cr>', { silent = true, noremap = true })
-- t
map('n', '<leader>tt',  '<cmd>Trouble<cr>')
map('n', '<leader>td',  '<cmd>Trouble diagnostics<cr>')
map('n', '<leader>tl',  '<cmd>Trouble loclist<cr>')
map('n', '<leader>tq',  '<cmd>Trouble quickfix<cr>')
-- v
map('n', '<leader>vo',  ':DiffviewOpen<CR>')
map('n', '<leader>vc',  ':DiffviewClose<CR>')
map('n', '<leader>vh',  ':DiffviewFileHistory<CR>')
map('n', '<leader>vl',  ':DiffviewFileHistory %<CR>')

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
map('v', '<C-/>',       'gc', { remap = true }) -- this should probably be a plug mapping
map('v', '<Leader>b',   'gb', { remap = true }) -- this should probably be a plug mapping
map('v', '<Leader>c',   'gc', { remap = true }) -- this should probably be a plug mapping
map('v', '<Leader>w',   '<Esc>:w<CR>')

------- Text object -------
map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
