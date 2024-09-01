local theme = require'lualine.themes.ayu_dark'
theme.normal.c.bg = 'none'
theme.normal.c.fg = '#efefef'

require 'lualine'.setup {
  options = {
    theme = theme
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1            -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    },
    lualine_d = {
      function()
        return require("package-info").get_status()
      end
    },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  }
}
