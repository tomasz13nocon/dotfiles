-- the order of these matters
require 'mason'.setup()
require 'mason-lspconfig'.setup {
  ensure_installed = {
    "lua_ls",
    "tsserver",
    "emmet_ls",
    "html",
    "cssls",
    "jsonls",
    "marksman",
    "tailwindcss",
    "astro",
    "rust_analyzer",
    "clangd",
    "svelte",
    "yamlls",
    "pyright",
    "cssmodules_ls",
    "prismals",
  }
}
require("neodev").setup {}

local lspconfig = require 'lspconfig'
-- local configs = require'lspconfig.configs'
-- local navic = require("nvim-navic")

-- cmp has more LSP client capabilities than vanilla neovim, so we need to let servers know this, to get completion for more stuff like auto imports, etc.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, bufnr)
  -- if client.server_capabilities.documentSymbolProvider then
  --   navic.attach(client, bufnr)
  -- end
  -- lsp_keymaps(bufnr)
  -- lsp_highlight_document(client)
end

local default_setup = {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.lua_ls.setup(default_setup)
-- try disabling html (emmet)
lspconfig.html.setup(default_setup)
lspconfig.cssls.setup(default_setup)
-- lspconfig.tsserver.setup(default_setup)
require("typescript").setup{
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        }
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        }
      }
    },
  }
}
lspconfig.tailwindcss.setup(default_setup)
lspconfig.astro.setup(default_setup)
lspconfig.rust_analyzer.setup(default_setup)
lspconfig.clangd.setup(default_setup)
lspconfig.svelte.setup(default_setup)
lspconfig.pyright.setup(default_setup)
lspconfig.cssmodules_ls.setup(default_setup)
lspconfig.prismals.setup(default_setup)
lspconfig.yamlls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    yaml = {
      keyOrdering = false
    }
  }
}
-- on_attach = function(client, bufnr)
--   on_attach()
--   client.server_capabilities.documentFormattingProvider = false
-- end,

lspconfig.emmet_ls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { 'html', 'css', 'sass', 'scss', 'less', 'svelte', 'astro' },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        -- ["bem.enabled"] = true,
        ["jsx.enabled"] = true,
      },
    },
  }
}

lspconfig.jsonls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}


local null_ls = require("null-ls")
null_ls.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- format on save
    if client.supports_method("textDocument/formatting") then
      -- vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        -- group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
  sources = {
    null_ls.builtins.formatting.autopep8,
    null_ls.builtins.diagnostics.eslint_d.with({
      filetypes = { "javascript", "typescript", "vue", "svelte", "astro", "javascriptreact", "typescriptreact" },
      condition = function()
        return require "null-ls.utils".root_pattern(
              "eslint.config.js",
              -- https://eslint.org/docs/user-guide/configuring/configuration-files#configuration-file-formats
              ".eslintrc",
              ".eslintrc.js",
              ".eslintrc.cjs",
              ".eslintrc.yaml",
              ".eslintrc.yml",
              ".eslintrc.json"
              -- "package.json"
            )(vim.api.nvim_buf_get_name(0)) ~= nil
      end
    }),
    -- null_ls.builtins.code_actions.eslint,
    null_ls.builtins.formatting.prettierd.with {
      filetypes = {
        "svelte",
        -- "astro",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "jsonc",
        "yaml",
        "markdown",
        "markdown.mdx",
        "graphql",
        "handlebars",
      },
      condition = function() -- use prettier only with prettierrc present
        return require "null-ls.utils".root_pattern(
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.yml",
              ".prettierrc.yaml",
              ".prettierrc.json5",
              ".prettierrc.js",
              ".prettierrc.cjs",
              ".prettierrc.toml",
              "prettier.config.js",
              "prettier.config.cjs"
            )(vim.api.nvim_buf_get_name(0)) ~= nil
      end,
    }
  }
}


local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn",  text = "" },
  { name = "DiagnosticSignHint",  text = "" },
  { name = "DiagnosticSignInfo",  text = "" },
}
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end
vim.diagnostic.config {
  virtual_text = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    active = signs,
    -- severity = { min = vim.diagnostic.severity.HrNT },
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

