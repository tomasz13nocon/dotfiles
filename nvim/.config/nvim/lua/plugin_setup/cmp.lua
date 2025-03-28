local cmp = require 'cmp'

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },

  window = {
    documentation = cmp.config.window.bordered(),
    completion = {
      -- border = "rounded",
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0,
    },
  },

  sources = cmp.config.sources({
    { name = 'ultisnips' },
    -- { name = 'emmet_vim' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    -- { name = 'copilot_cmp' },
    { name = 'path' },
    { name = 'buffer' },
  }
  -- { -- these won't be displayed when the ones above are availible
  -- }
  ),

  experimental = {
    ghost_text = true
  },

  preselect = cmp.PreselectMode.None,

  mapping = {
    ["<Tab>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          -- else
          --   cmp.complete()
        end
      end,
      i = function(fallback)
        if cmp.get_selected_entry() ~= nil then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        elseif cmp.visible() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
        elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
        else
          fallback()
        end
      end,
      s = function(fallback)
        if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
        else
          fallback()
        end
      end
    }),
    ["<S-Tab>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        else
          cmp.complete()
        end
      end,
      i = function(fallback)
        -- if cmp.visible() then
        -- cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), 'm', true)
        else
          fallback()
        end
      end,
      s = function(fallback)
        if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), 'm', true)
        else
          fallback()
        end
      end
    }),
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
    ['<C-n>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end
    }),
    ['<C-p>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end
    }),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
    ['<CR>'] = cmp.mapping({
      i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
      c = cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
    }),
  },

  -- mapping = cmp.mapping.preset.insert({
  --     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  --     ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --     ['<C-Space>'] = cmp.mapping.complete(),
  --     ['<C-e>'] = cmp.mapping.abort(),
  --     ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --     ['<Tab>'] = cmp.mapping({
  --         -- c = function()
  --         --   if cmp.visible() then
  --         --     cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
  --         --   else
  --         --     cmp.complete()
  --         --   end
  --         -- end,
  --         i = function(fallback)
  --           if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
  --             vim.api.nvim_feedkeys(t("<Plug>(ultisnips_expand)"), 'm', true)
  --           elseif cmp.visible() then
  --             cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
  --           elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
  --             vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
  --           else
  --             fallback()
  --           end
  --         end,
  --         s = function(fallback)
  --           if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
  --             vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
  --           else
  --             fallback()
  --           end
  --         end
  --       }),
  --     ["<S-Tab>"] = cmp.mapping({
  --         -- c = function()
  --         --   if cmp.visible() then
  --         --     cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
  --         --   else
  --         --     cmp.complete()
  --         --   end
  --         -- end,
  --         i = function(fallback)
  --           if cmp.visible() then
  --             cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
  --           elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
  --             return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
  --           else
  --             fallback()
  --           end
  --         end,
  --         s = function(fallback)
  --           if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
  --             return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
  --           else
  --             fallback()
  --           end
  --         end
  --       }),
  --   }),

  -- COOL COLOR BLOCKS
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
      -- local strings = vim.split(kind.kind, "%s", { trimempty = true })
      -- kind.kind = " " .. strings[1] .. " "
      -- kind.menu = "    (" .. strings[2] .. ")"
      kind.kind = " " .. vim_item.kind .. " "
      if entry.source.name == 'nvim_lsp' then
        -- Display which LSP servers this item came from.
        local lspserver_name = nil
        pcall(function()
          lspserver_name = entry.source.source.client.name
          vim_item.menu = "    [" .. lspserver_name .. "]"
        end)
      end
      return kind
    end,
  },
  -- formatting = {
  --   format = require'lspkind'.cmp_format(),
  -- },

  -- DISABLE FOR COMMENTS
  enabled = function()
    local context = require 'cmp.config.context'
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      return not context.in_treesitter_capture("comment")
          and not context.in_syntax_group("Comment")
    end
  end,

  -- REVERSE ORDER CLOSE TO SCREEN BOTTOM
  view = {
    entries = { name = 'custom', selection_order = 'near_cursor' }
  },
})

-- cmp.setup.cmdline('/', {
--     sources = cmp.config.sources({
--         { name = 'nvim_lsp_document_symbol' }
--       }, {
--         { name = 'buffer' }
--       })
--   })
cmp.setup.cmdline('/', {
  completion = { autocomplete = false },
  sources = {
    { name = 'nvim_lsp_document_symbol' },
    { name = 'buffer',                  opts = { keyword_pattern = [=[[^[:blank:]].*]=] } }
  }
})

cmp.setup.cmdline(':', {
  -- completion = { autocomplete = true },
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
