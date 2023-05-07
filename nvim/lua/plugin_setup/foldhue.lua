require('foldhue').enable()
require('foldhue').fade = function(hl)
  local rgb = string.format('%0X', hl.foreground)  -- octal to hex
  local r, g, b = rgb:sub(1, 2), rgb:sub(3, 4), rgb:sub(5, 6)
  local f = (1)
  -- hex to number, so we can do math:
  r, g, b = vim.fn.str2nr(r, 16) * f, vim.fn.str2nr(g, 16) * f, vim.fn.str2nr(b, 16) * f
  -- back to hex:
  hl.foreground = vim.fn.printf('#%x%x%x', math.floor(r + 0.5), math.floor(g + 0.5), math.floor(b + 0.5))
  return hl
end
