require'plugins'

vim.opt.number = true
vim.opt.swapfile = false
vim.opt.timeoutlen = 600
vim.opt.ignorecase = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
-- Don't use swap files, because they are pain to deal with.
--vim.opt.swapfile = false
vim.g.do_filetype_lua = 1

vim.g.mapleader = ' '
vim.keymap.set('n', '<Leader>c', 'gcc', {remap = true}) -- this should probably be a plug mapping
vim.keymap.set('v', '<Leader>c', 'gc', {remap = true}) -- this should probably be a plug mapping
vim.keymap.set('n', '<C-n>', ':Neotree<CR>')
vim.keymap.set('', '<Leader>d', '"_d')
vim.keymap.set('', '<Leader>D', '"_D')
vim.keymap.set('', '<Leader>x', '"_x')
vim.keymap.set('', '<Leader>X', '"_X')
vim.keymap.set('', '<Leader>h', ':nohlsearch<CR>')
vim.keymap.set('', '<Leader>r', ':e ~/.config/nvim/init.lua<CR>')
vim.keymap.set('', '<Leader>R', ':luafile ~/.config/nvim/lua/plugins.lua<CR>:luafile ~/.config/nvim/init.lua<CR>')
vim.keymap.set('', '<Leader>w', ':w<CR>')
vim.keymap.set('', 'J', '4j')
vim.keymap.set('', 'K', '4k')
vim.keymap.set('', '+', '"+y')
vim.keymap.set('', '<C-h>', ':BufferPrevious<CR>')
vim.keymap.set('', '<C-S-h>', ':BufferMovePrevious<CR>')
vim.keymap.set('', '<C-j>', ':join<CR>')
vim.keymap.set('', '<C-l>', ':BufferNext<CR>')
vim.keymap.set('', '<C-S-l>', ':BufferMoveNext<CR>')
-- vim.keymap.set('', '<C-p>', ':Files<CR>')
-- vim.keymap.set('', '<C-S-p>', ':Rg<CR>')
vim.keymap.set('', '<C-p>', '<cmd>Telescope find_files<cr>')
vim.keymap.set('', '<C-S-p>', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('', '<C-q>', ':bd<CR>')
vim.keymap.set('', '<C-1>', ':BufferGoto 1<CR>')
vim.keymap.set('', '<C-2>', ':BufferGoto 2<CR>')
vim.keymap.set('', '<C-3>', ':BufferGoto 3<CR>')
vim.keymap.set('', '<C-4>', ':BufferGoto 4<CR>')
vim.keymap.set('', '<C-5>', ':BufferGoto 5<CR>')
vim.keymap.set('', '<C-6>', ':BufferGoto 6<CR>')
vim.keymap.set('', '<C-7>', ':BufferGoto 7<CR>')
vim.keymap.set('', '<C-8>', ':BufferGoto 8<CR>')
vim.keymap.set('', '<C-9>', ':BufferGoto 9<CR>')
vim.keymap.set('', '<C-0>', ':BufferGoto 10<CR>')

vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	callback = function()
		vim.opt.cursorline = true
	end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	callback = function()
		vim.opt.cursorline = false
	end,
})

vim.cmd("match todo /TODO/");
vim.cmd("2match todo /NOW/");

-- vim.g.tokyonight_style = "night"
-- vim.cmd("colorscheme tokyonight")
vim.cmd("colorscheme ayu")
-- vim.cmd("hi Comment cterm=none gui=none")
vim.cmd("hi Comment guifg=#646b6a")
vim.cmd("hi Grey guifg=#646b6a")
vim.cmd("hi LineNr guifg=#646b6a") -- 646b8a

-- cmp
local cmp = require'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
      { name = 'buffer' },
    })
})
require'lspconfig'.tsserver.setup{}
require'Comment'.setup()
require'nvim-treesitter'.setup{}
require'nvim-treesitter.configs'.setup {
	ensure_installed = { "javascript", "lua", "css", "scss" },
	highlight = { enable = true },
	indent = { enable = true },
}
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<Esc>"] = "close",
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      }
    }
  }
}
require('impatient')

local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.emmet_ls.setup({
    -- on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ["bem.enabled"] = true,
        },
      },
    }
})

-- TODO
-- folds
-- snippets
