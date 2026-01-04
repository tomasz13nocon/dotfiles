vim.api.nvim_create_user_command('Daily', function(opts)
  if vim.fn.isdirectory("daily") == 0 then
    vim.api.nvim_err_writeln("Error: 'daily' directory does not exist")
    return
  end

  local offset = tonumber(opts.args) or 0
  local date = os.date("*t", os.time() + offset * 86400)
  local filename = string.format("daily/%02d.%02d.%02d.md",
    date.year % 100, date.month, date.day)

  vim.cmd("edit " .. filename)
end, { nargs = '?' })
