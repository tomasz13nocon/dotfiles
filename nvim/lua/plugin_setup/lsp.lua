-- the order of these matters
require 'mason'.setup()
require 'mason-lspconfig'.setup {
  ensure_installed = {
    "lua_ls",
    "ts_ls",
    "emmet_language_server",
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
    "phpactor",
    "omnisharp",
    "vtsls",
  }
}
require("neodev").setup {}

local lspconfig = require 'lspconfig'
-- local configs = require'lspconfig.configs'
-- local navic = require("nvim-navic")

-- cmp has more LSP client capabilities than vanilla neovim, so we need to let servers know this, to get completion for more stuff like auto imports, etc.
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities(),
  -- returns configured operations if setup() was already called
  -- or default operations if not
  require 'lsp-file-operations'.default_capabilities()
)

local on_attach = function(client, bufnr)
  -- if client.server_capabilities.documentSymbolProvider then
  --   navic.attach(client, bufnr)
  -- end
  -- lsp_keymaps(bufnr)
  -- lsp_highlight_document(client)
  if client.server_capabilities.signatureHelpProvider then
    require('lsp-overloads').setup(client, {})
    vim.keymap.set("n", "<leader>k", ":LspOverloadsSignature<CR>", { noremap = true, silent = true, buffer = bufnr })
  end

  -- Get diagnostics from entire workspace
  require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
end

local default_setup = {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- custom protobuf lsp config
local configs = require('lspconfig.configs')
local util = require('lspconfig.util')
configs["protobuf-language-server"] = {
  default_config = {
    cmd = { 'protobuf-language-server' },
    filetypes = { 'proto', 'cpp' },
    root_fir = util.root_pattern('.git'),
    single_file_support = true,
  }
}

lspconfig.lua_ls.setup(default_setup)
lspconfig["protobuf-language-server"].setup(default_setup)
-- try disabling html (emmet)
lspconfig.html.setup(default_setup)
lspconfig.cssls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    provideFormatter = false
  },
  settings = {
    css = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    }
  }
})
-- lspconfig.ts_ls.setup(default_setup)
lspconfig.vtsls.setup(default_setup)
-- require("typescript").setup {
--   server = {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     settings = {
--       typescript = {
--         inlayHints = {
--           includeInlayParameterNameHints = 'all',
--           includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--           includeInlayFunctionParameterTypeHints = true,
--           includeInlayVariableTypeHints = true,
--           includeInlayPropertyDeclarationTypeHints = true,
--           includeInlayFunctionLikeReturnTypeHints = true,
--           includeInlayEnumMemberValueHints = true,
--         }
--       },
--       javascript = {
--         inlayHints = {
--           includeInlayParameterNameHints = 'all',
--           includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--           includeInlayFunctionParameterTypeHints = true,
--           includeInlayVariableTypeHints = true,
--           includeInlayPropertyDeclarationTypeHints = true,
--           includeInlayFunctionLikeReturnTypeHints = true,
--           includeInlayEnumMemberValueHints = true,
--         }
--       }
--     },
--   }
-- }
-- using mrcjkb/rustaceanvim instead
lspconfig.mdx_analyzer.setup(default_setup)
lspconfig.rust_analyzer.setup(default_setup)
lspconfig.phpactor.setup(default_setup)
lspconfig.prismals.setup(default_setup)
lspconfig.pyright.setup(default_setup)
lspconfig.clangd.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "hpp" },
})
lspconfig.svelte.setup(default_setup)
lspconfig.astro.setup(default_setup)
lspconfig.tailwindcss.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
          { "cx\\(([^)]*)\\)",  "(?:'|\"|`)([^']*)(?:'|\"|`)" }
        },
      },
    },
  },
})
lspconfig.cssmodules_ls.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.server_capabilities.definitionProvider = false
    on_attach(client, bufnr)
  end,
  init_options = {
    camelCase = 'dashes',
  },
}
lspconfig.omnisharp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = {
    ["textDocument/definition"] = require('omnisharp_extended').handler,
  },
  cmd = { "omnisharp", '--languageserver', '--hostPID', tostring(vim.fn.getpid()) },
  -- enable_editorconfig_support = true, -- setting from .editorconfig
  -- enable_ms_build_load_projects_on_demand = true,
  -- enable_roslyn_analyzers = true,
  -- analyze_open_documents_only = true,
  -- organize_imports_on_format = true,
  -- may result in slow completion responsiveness
  enable_import_completion = true,
  -- sdk_include_prereleases = true,
}
lspconfig.yamlls.setup {
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

-- aca/emmet-ls
-- lspconfig.emmet_ls.setup{
--   capabilities = capabilities,
--   on_attach = on_attach,
--   filetypes = { 'html', 'css', 'sass', 'scss', 'less', 'svelte', 'astro' },
--   init_options = {
--     html = {
--       options = {
--         -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
--         -- ["bem.enabled"] = true,
--         ["jsx.enabled"] = true,
--       },
--     },
--   }
-- }

-- olrtg/emmet-ls (fork)
lspconfig.emmet_language_server.setup({
  filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "astro", "vue" },
  -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
  -- **Note:** only the options listed in the table are supported.
  init_options = {
    ---@type table<string, string>
    includeLanguages = {},
    --- @type string[]
    excludeLanguages = {},
    --- @type string[]
    extensionsPath = {},
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
    preferences = {},
    --- @type boolean Defaults to `true`
    showAbbreviationSuggestions = true,
    --- @type "always" | "never" Defaults to `"always"`
    showExpandedAbbreviation = "always",
    --- @type boolean Defaults to `false`
    showSuggestionsAsSnippets = false,
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
    syntaxProfiles = {},
    --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
    variables = {},
  },
})

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
    null_ls.builtins.formatting.black,
    null_ls.builtins.diagnostics.eslint.with({
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
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
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
