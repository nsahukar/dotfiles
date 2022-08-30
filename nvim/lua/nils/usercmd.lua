local telescope = require('nils.telescope')

-- USER COMMANDS
--
-- Files: using telescope to find files in any given directory
-- <args>
--  - cwd: current working directory (optional)
vim.api.nvim_create_user_command('Files', function(tbl)
  telescope.find_files(tbl.args)
end, {
  nargs = '?',
  complete = 'dir'
})
