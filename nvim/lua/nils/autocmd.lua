-- CursorLine highlight applied in ONLY current window
vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufEnter' },
  {
    group = vim.api.nvim_create_augroup('cursorline', { clear = true }),
    pattern = '*',
    callback = function()
      vim.wo.cursorline = true
    end
  }
)

vim.api.nvim_create_autocmd({ 'WinLeave' },
  {
    group = vim.api.nvim_create_augroup('nocursorline', { clear = true }),
    pattern = '*',
    callback = function()
      vim.wo.cursorline = false
    end
  }
)

-- Custom tabs from languages
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' },
  {
    group = vim.api.nvim_create_augroup('langtabs', { clear = true }),
    pattern = { '*.lua', '*.js', '*.html' },
    callback = function()
      vim.bo.tabstop = 2
      vim.bo.shiftwidth = 0
    end
  }
)

-- Format following file types with 'dprint' on file save
-- js, ts, html, css
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  group = vim.api.nvim_create_augroup('dprintFmt', { clear = true }),
  pattern = { '*.js', '*.ts', '*.html', '*.css' },
  callback = function ()
    local bufname = vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
    vim.fn.jobstart({"dprint", "-c", "/home/nils/.config/dprint/dprint.json", "fmt", bufname}, {
      stdout_buffered = true,
      on_stdout = function (_, res)
        if res then
          vim.cmd(':e')
        end
      end
    }) 
  end
})
