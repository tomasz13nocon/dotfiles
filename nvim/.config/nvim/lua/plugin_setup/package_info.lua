require 'package-info'.setup {
  hide_up_to_date = true,
  highlights = {
    up_to_date = { fg = "#3C4048" }, -- Text color for up to date dependency virtual text
    outdated = { fg = "#d19a66" },   -- Text color for outdated dependency virtual text
  },
  icons = {
    enable = true,            -- Whether to display icons
    style = {
      up_to_date = "   |  ", -- Icon for up to date dependencies
      outdated = "   |  ", -- Icon for outdated dependencies
    },
  },
}
