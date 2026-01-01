-- the order of these matters
require 'mason'.setup()
require 'mason-lspconfig'.setup {
  ensure_installed = {
    "lua_ls",
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
    "ts_ls",
    -- "vtsls",
  }
}

-- cmp has more LSP client capabilities than vanilla neovim, so we need to let servers know this, to get completion for more stuff like auto imports, etc.
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),

  -- require('cmp_nvim_lsp').default_capabilities(),
  require('blink.cmp').get_lsp_capabilities(),

  -- returns configured operations if setup() was already called
  -- or default operations if not
  require 'lsp-file-operations'.default_capabilities()
)

local on_attach = function(client, bufnr)
  if client.server_capabilities.signatureHelpProvider then
    require('lsp-overloads').setup(client, {})
    vim.keymap.set("n", "<leader>k", ":LspOverloadsSignature<CR>", { noremap = true, silent = true, buffer = bufnr })
  end

  -- Get diagnostics from entire workspace
  require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
end

vim.lsp.config("*", {
  capabilities = capabilities,
  on_attach = on_attach,
})

vim.lsp.enable "html"
vim.lsp.enable "mdx_analyzer"
vim.lsp.enable "phpactor"
vim.lsp.enable "prismals"
vim.lsp.enable "pyright"
vim.lsp.enable "astro"

vim.lsp.config.lua_ls = {
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          "vim"
        }
      }
    }
  }
}
vim.lsp.enable "lua_ls"

vim.lsp.config.cssls = {
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
}
vim.lsp.enable "cssls"

vim.lsp.config.ts_ls = {
  init_options = {
    typescript = {
      tsdk = "/home/user/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib/"
    },
    preferences = {
      includeCompletionsForModuleExports = true,
      includeCompletionsForImportStatements = true,
      importModuleSpecifierPreference = "non-relative",
    },
  },
}
vim.lsp.enable "ts_ls"
-- lspconfig.vtsls.setup(default_setup)
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

vim.lsp.config.rust_analyzer = {
  settings = {
    ["rust-analyzer"] = {
      installRustc = false,
      installCargo = false,
      rustfmt = {
        extraArgs = { "+nightly" }
      },
      checkOnSave = true,
      check = {
        command = "clippy",
        allTargets = true,
        features = "all",
        extraArgs = { "--", "-W", "clippy::needless_pass_by_value" },
      }
    }
  }
}
vim.lsp.enable "rust_analyzer"

vim.lsp.config.clangd = {
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "hpp" },
}
vim.lsp.enable "clangd"

vim.lsp.config.svelte = {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.js", "*.ts" },
      callback = function(ctx)
        client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
      end,
    })
  end,
}
vim.lsp.enable "svelte"

vim.lsp.config.tailwindcss = {
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "cva\\(([^)]*)\\)",          "[\"'`]([^\"'`]*).*?[\"'`]" },
          { "cx\\(([^)]*)\\)",           "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { "([\"'`][^\"'`]*.*?[\"'`])", "[\"'`]([^\"'`]*).*?[\"'`]" }
        },
      },
    },
  },
}
vim.lsp.enable "tailwindcss"

vim.lsp.config.cssmodules_ls = {
  on_attach = function(client, bufnr)
    client.server_capabilities.definitionProvider = false
    on_attach(client, bufnr)
  end,
  init_options = {
    camelCase = 'dashes',
  },
}
vim.lsp.enable "cssmodules_ls"

vim.lsp.config.omnisharp = {
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
vim.lsp.enable "omnisharp"

vim.lsp.config.yamlls = {
  settings = {
    yaml = {
      keyOrdering = false
    }
  }
}
vim.lsp.enable "yamlls"


-- olrtg/emmet-ls (fork)
vim.lsp.config.emmet_language_server = {
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
}
vim.lsp.enable "emmet_language_server"

vim.lsp.config.jsonls = {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}
vim.lsp.enable "jsonls"


local none_ls = require("null-ls")
none_ls.setup {
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
    none_ls.builtins.formatting.black,
    require("none-ls.diagnostics.eslint_d").with({
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
    require("none-ls.code_actions.eslint"),
    none_ls.builtins.formatting.prettierd.with {
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

vim.diagnostic.config {
  virtual_text = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    -- severity = { min = vim.diagnostic.severity.HrNT },
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
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

