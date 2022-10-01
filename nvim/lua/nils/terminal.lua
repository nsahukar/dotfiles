local t_buf = nil
local t_win = nil

local open_terminal = function ()
  -- If buffer does not exists (given the buffer number)
  --    Create a new terminal buffer
  --        Save buffer number and window id
  if vim.fn.bufexists(t_buf) == 0 then
    vim.cmd('split | winc J | resize 24 | term')
    t_win = vim.fn.win_getid()
    t_buf = vim.fn.bufnr('%')

  -- If buffer exists
  --    Attach the existing buffer to window
  --        Save new window id
  else
    if vim.fn.win_gotoid(t_win) == 0 then
      vim.cmd('sbuffer ' .. t_buf .. ' | winc J | resize 24')
      t_win = vim.fn.win_getid()
    end
  end

  -- Go to insert mode (immediately)
  vim.cmd('startinsert')
end

local close_terminal = function ()
  vim.cmd('hide')
end


local M = {}

M.toggle_terminal = function()
  if vim.fn.win_gotoid(t_win) == 1 then
    close_terminal()
  else
    open_terminal()
  end
end

return M
