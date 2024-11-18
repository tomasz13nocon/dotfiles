local bufferline = require('bufferline')

-- Global function for cycling without wrap
function _G.cycle_no_wrap(direction)
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = bufferline.get_elements().elements -- Get bufferline's buffer list

  if #buffers == 0 then return end -- No buffers

  local current_pos
  for i, buffer in ipairs(buffers) do
    if buffer.id == current_buf then
      current_pos = i
      break
    end
  end

  if direction == "prev" and current_pos > 1 then
    vim.cmd("BufferLineCyclePrev")
  elseif direction == "next" and current_pos < #buffers then
    vim.cmd("BufferLineCycleNext")
  end
end

function _G.delbuf()
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = bufferline.get_elements().elements -- Get bufferline's buffer list

  if #buffers == 0 then return end -- No buffers

  local current_pos
  for i, buffer in ipairs(buffers) do
    if buffer.id == current_buf then
      current_pos = i
      break
    end
  end

  -- If the current buffer is the last one, focus the previous buffer (to the left)
  if current_pos == #buffers then
    vim.cmd("BufferLineCyclePrev")
  else
    -- Otherwise, focus the next buffer (to the right)
    vim.cmd("BufferLineCycleNext")
  end

  -- Now close the original buffer (current_buf)
  vim.cmd("bdelete " .. current_buf)
end
