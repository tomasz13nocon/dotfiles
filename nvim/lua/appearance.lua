-- vim.g.tokyonight_style = "night"
-- local colorscheme = "tokyonight"

-- ayu tokyonight-night onedark tomorrow darkplus ferrum codemonkey ayu-mirage aurora system76 slate colorsbox-stbright hybrid-reverse jellybeans
local colorscheme = "aurora-mod"


local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

local hi = function(name, val)
  vim.api.nvim_set_hl(0, name, val)
end

-- ADJUSTMENTS --
hi("Comment", { fg = "#646b6a" } )
vim.cmd("match todo /TODO/")
vim.cmd("2match todo /NOW/")
-- vim.cmd("match ErrorMsg '\\s\\+$'") -- trailing spaces
vim.cmd("2match ErrorMsg '^\\s\\{-}\\zs\\t\\+'") -- leading tabs
-- vim.cmd("match MoreMsg / \\d+/");
vim.g.italic_comments = false
if (colorscheme == "ayu") then
  hi("Grey", { fg = "#646b6a" })
  hi("LineNr", { fg = "#646b6a" }) -- #646b8a
  hi("Folded", { bg = "#342843", fg = "#eeeeee" })
  hi("matchTag", { fg = "#eeeeee", bg = "#666666" })
elseif (colorscheme == "aurora") then
  hi("Folded", { bg = "#2F333B", fg = "#eeeeee" })
  hi("Search", { bg = "#E2D626", fg = "#000000" })
  hi("IncSearch", { bg = "#FF9641", fg = "#000000" })
  hi("FloatBorder", { default = true, bg = "bg" })
end

-- CMP COOL COLOR BLOCKS --
local kind_highlights = {
  PmenuSel = { bg = "#282C34", fg = "NONE" },
  Pmenu = { fg = "#C5CDD9", bg = "#22252A" },

  CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", fmt = "strikethrough" },
  CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", fmt = "bold" },
  CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", fmt = "bold" },
  CmpItemMenu = { fg = "#C792EA", bg = "NONE", fmt = "italic" },

  CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" },
  CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" },
  CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" },

  -- CmpItemKindText = { fg = "#C3E88D", bg = "#9FBD73" },
  CmpItemKindText = { fg = "#333333", bg = "#9FBD73" },
  CmpItemKindEnum = { fg = "#C3E88D", bg = "#9FBD73" },
  -- CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" },
  CmpItemKindKeyword = { fg = "#444444", bg = "#9FBD73" },

  -- CmpItemKindConstant = { fg = "#FFE082", bg = "#D4BB6C" },
  CmpItemKindConstant = { fg = "#222222", bg = "#D4BB6C" },
  CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" },
  CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" },

  CmpItemKindFunction = { fg = "#EADFF0", bg = "#A377BF" },
  CmpItemKindStruct = { fg = "#EADFF0", bg = "#A377BF" },
  CmpItemKindClass = { fg = "#EADFF0", bg = "#A377BF" },
  CmpItemKindModule = { fg = "#EADFF0", bg = "#A377BF" },
  CmpItemKindOperator = { fg = "#EADFF0", bg = "#A377BF" },

  -- CmpItemKindVariable = { fg = "#C5CDD9", bg = "#7E8294" },
  CmpItemKindVariable = { fg = "#D5DDE9", bg = "#7E8294" },
  CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294" },

  CmpItemKindUnit = { fg = "#F5EBD9", bg = "#D4A959" },
  CmpItemKindSnippet = { fg = "#F5EBD9", bg = "#D4A959" },
  CmpItemKindFolder = { fg = "#F5EBD9", bg = "#D4A959" },

  CmpItemKindMethod = { fg = "#DDE5F5", bg = "#6C8ED4" },
  CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" },
  CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" },

  CmpItemKindInterface = { fg = "#D8EEEB", bg = "#58B5A8" },
  CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
  CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
}
for k, v in pairs(kind_highlights) do
  vim.cmd(string.format("hi %s guibg=%s guifg=%s", k, v.bg, v.fg) .. (v.fmt and ("gui=" .. v.fmt) or ""))
end