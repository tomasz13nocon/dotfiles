local hi = vim.api.nvim_set_hl

local heading_colors = {
  { fg = "#E06C75", bg = "#3A2024" },
  { fg = "#E5C07B", bg = "#3A3020" },
  { fg = "#98C379", bg = "#263A26" },
  { fg = "#56B6C2", bg = "#20363A" },
  { fg = "#61AFEF", bg = "#203040" },
  { fg = "#C678DD", bg = "#35243A" },
}

for i, color in ipairs(heading_colors) do
  hi(0, "RenderMarkdownH" .. i, {
    fg = color.fg,
    bold = true,
  })

  hi(0, "RenderMarkdownH" .. i .. "Bg", {
    fg = color.fg,
    bg = color.bg,
    bold = true,
  })
end

require('render-markdown').setup({
  heading = {
    icons = { '󰉫 ', '󰉬 ', '󰉭 ', '󰉮 ', '󰉯 ', '󰉰 ' },
  },
})
