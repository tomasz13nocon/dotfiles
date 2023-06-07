vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.termguicolors = true
vim.opt.timeoutlen = 600
vim.opt.ignorecase = true
vim.opt.smartcase = true -- both ignorecase and smartcase need to be true
vim.opt.undofile = true
vim.opt.smartindent = true
vim.opt.swapfile = false -- Don't use swap files, because they are pain to deal with.
vim.opt.showmode = false
-- vim.opt.splitright = true
-- vim.opt.splitbelow = true
-- vim.opt.cmdheight = 0
-- vim.opt.updatetime = 300
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
-- tab stuff
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.foldopen:remove("search")
vim.opt.foldmethod = "marker";
vim.opt.foldtext = [[getline(v:foldstart) . ' ...   ' . (v:foldend - v:foldstart + 1)]] -- . trim(getline(v:foldend)) 
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.opt.completeopt = "menu,menuone,noselect" -- recommended by cmp
-- tab:» ,
vim.opt.listchars = "tab:  ,trail:•" -- ·•»→›␣↲¤›
vim.opt.list = true
-- vim.opt.showbreak = "+ " -- doesn't work
vim.opt.conceallevel = 0

vim.g.do_filetype_lua = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd("abbr q qa")

vim.api.nvim_create_user_command("TTS", "set et | retab", {})
