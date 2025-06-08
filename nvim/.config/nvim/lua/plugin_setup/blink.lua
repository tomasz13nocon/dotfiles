require('blink.cmp').setup {
  keymap = {
    preset = "super-tab",
    -- ['<CR>'] = { 'accept', 'fallback' },
    ['<Tab>'] = {
      function(cmp)
        if cmp.snippet_active() then
          return cmp.accept()
        else
          return cmp.select_and_accept()
        end
      end,
      'snippet_forward',
      'fallback'
    },
  },
  appearance = {
    -- Sets the fallback highlight groups to nvim-cmp's highlight groups
    -- Useful for when your theme doesn't support blink.cmp
    -- Will be removed in a future release
    use_nvim_cmp_as_default = true,
    -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = {
      auto_show = true,
    },
    ghost_text = {
      enabled = true,
    },
    list = { selection = { preselect = false, auto_insert = false } },
    accept = {
      auto_brackets = {
        enabled = false,
      },
    },
    menu = {
      border = "none",
      draw = {
        columns = {
          { "kind_icon" },
          { "label",    "label_description", gap = 1 },
        },
        padding = { 0, 1 },
        components = {
          kind_icon = {
            ellipsis = false,
            text = function(ctx) return "  " .. ctx.kind_icon .. ctx.icon_gap .. "  " end,
            highlight = function(ctx) return ctx.kind_hl end,
          },
          kind = {
            ellipsis = false,
            width = { fill = true },
            text = function(ctx) return ctx.kind .. " " end,
            highlight = function(ctx) return ctx.kind_hl end,
          },
        }
      }
    }
  },

  signature = { enabled = true },
  snippets = { preset = 'luasnip' },
  sources = {
    default = { 'lsp', 'path', 'buffer', 'snippets' },
    -- default = { 'snippets', 'ultisnips' },
    -- providers = {
    --   ultisnips = {
    --     name = 'ultisnips',
    --     module = 'blink.compat.source',
    --     score_offset = 100,
    --   }
    -- }
  },
  -- snippets = {
  -- preset = "luasnip",
  -- expand = function()
  --   vim.fn["UltiSnips#Anon"]()
  -- end,
  -- },
}
