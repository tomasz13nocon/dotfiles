local util = require("conform.util")

require 'conform'.setup {
  formatters_by_ft = {
    -- lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    -- python = { "isort", "black" },
    -- You can customize some of the format options for the filetype (:help conform.format)
    rust = { "rustfmt", lsp_format = "fallback" },
    -- Conform will run the first available formatter
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
  },
  format_on_save = {
    undojoin = true,
    -- timeout_ms = 3500,
  },
  formatters = {
    rustfmt = {
      inherit = false,
      command = "nix",
      args = function(self, ctx)
        local args = { "shell", "fenix#default.rustfmt", "-c", "rustfmt", "--emit=stdout" }
        local edition = util.parse_rust_edition(ctx.dirname) or self.options.default_edition
        table.insert(args, "--edition=" .. edition)

        return args
      end,
    }
  }
}
