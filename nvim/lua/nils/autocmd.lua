-- CursorLine highlight applied in ONLY current window
vim.api.nvim_create_autocmd({'VimEnter', 'WinEnter', 'BufEnter'},
  {
    group = vim.api.nvim_create_augroup('cursorline', { clear = true }),
    pattern = '*',
    callback = function()
      vim.wo.cursorline = true
    end
  }
)

vim.api.nvim_create_autocmd({'WinLeave'},
  {
    group = vim.api.nvim_create_augroup('nocursorline', { clear = true }),
    pattern = '*',
    callback = function()
      vim.wo.cursorline = false
    end
  }
)

-- Custom tabs from languages
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'},
  {
    group = vim.api.nvim_create_augroup('langtabs', { clear = true }),
    pattern = {'*.lua', '*.js', '*.html'},
    callback = function()
      vim.bo.tabstop = 2
      vim.bo.shiftwidth = 0
    end
  }
)
