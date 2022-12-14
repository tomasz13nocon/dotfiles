-- the order of these matters
require'mason'.setup()
require'mason-lspconfig'.setup{
  ensure_installed = {
    "sumneko_lua",
    "tsserver",
    "emmet_ls",
    "html",
    "cssls",
    "jsonls",
  }
}
require("neodev").setup{}

local lspconfig = require'lspconfig'
-- local configs = require'lspconfig/configs'

-- cmp has more LSP client capabilities than vanilla neovim, so we need to let servers know this, to get completion for more stuff like auto imports, etc.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, bufnr)
  -- lsp_keymaps(bufnr)
  -- lsp_highlight_document(client)
end

local default_setup = {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.sumneko_lua.setup(default_setup)
lspconfig.html.setup(default_setup)
lspconfig.cssls.setup(default_setup)
lspconfig.tsserver.setup(default_setup)
  -- on_attach = function(client, bufnr)
  --   on_attach()
  --   client.server_capabilities.documentFormattingProvider = false
  -- end,

lspconfig.emmet_ls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        -- ["bem.enabled"] = true,
      },
    },
  }
}

lspconfig.jsonls.setup{
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}


require("null-ls").setup{
  sources = {
    -- null_ls.builtins.diagnostics.eslint,
  }
}


local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end
vim.diagnostic.config{
  virtual_text = false,
  signs = {
    active = signs,
  },
  -- update_in_insert = true,
  -- underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
