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

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lspbindings', { clear = true }),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Format following file types with 'dprint' on file save
-- js, ts, html, css
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  group = vim.api.nvim_create_augroup('dprintFmt', { clear = true }),
  pattern = { '*.js', '*.ts', '*.html', '*.css' },
  callback = function()
    local curpos = vim.api.nvim_win_get_cursor(0)
    local fname = vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
    vim.fn.jobstart({ "dprint", "-c", "/home/nils/.config/dprint/dprint.json", "fmt", fname }, {
      stdout_buffered = true,
      on_stdout = function(_, out)
        if out then
          vim.api.nvim_command "edit"
          local buflinecount = vim.api.nvim_buf_line_count(0)
          if curpos[1] > buflinecount then
            curpos[1] = buflinecount
          end
          vim.api.nvim_win_set_cursor(0, curpos)
        end
      end
      -- on_stderr = function (_, err)
      --   if err then
      --     print("Error:")
      --     P(err)
      --   end
      -- end,
      -- on_exit = function ()
      --   P("Exit")
      -- end
    })
  end
})
