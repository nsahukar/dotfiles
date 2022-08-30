local M = {}

M.find_files = function(cwd)
  if string.len(cwd) == 0 then
    vim.cmd('Telescope find_files')
  else
    vim.cmd('Telescope find_files cwd=' .. cwd)
  end
end

return M
