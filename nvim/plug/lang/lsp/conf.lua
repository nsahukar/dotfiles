local nvim_lsp = require('lspconfig')
local on_attach = function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- require "lsp_signature".on_attach()

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

-- Enable the following language servers
-- local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
local servers = { 'clangd', 'gopls', 'tsserver', 'html', 'cssls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { 
	  on_attach = on_attach,
  	capabilities = capabilities,
  }
end

-- Map :Format to vim.lsp.buf.formatting()
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

-- Set completeopt to have a better completion experience
-- vim.o.completeopt="menuone,noinsert"
-- vim.o.completeopt="menuone,noselect,noinsert"


-- Control diagnostics
--
-- Clear diagnostic indicators
function lsp_diagnostic_indicators_clear()
  vim.lsp.diagnostic.clear(0)
end

-- Disable diagnostic indicators
function lsp_diagnostic_indicators_disable()
  -- turn off all indicators
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
  	  signs = false,
  	  virtual_text = false,
  	  underline = false,
      update_in_insert = false,
    }
  )
end

-- Redraw diagnostic indicators
function lsp_diagnostic_indicators_redraw()
  for _,lsp_client_id in pairs(vim.tbl_keys(vim.lsp.buf_get_clients())) do
    vim.lsp.handlers['textDocument/publishDiagnostics'](
      nil,
      'textDocument/publishDiagnostics', {
          diagnostics = vim.lsp.diagnostic.get(0, lsp_client_id),
          uri = vim.uri_from_bufnr(0)
      },
      lsp_client_id
    )
  end
end

-- Enable signs and virtual text diagnostic indicators
function lsp_diagnostic_indicators_signsvirtualtext()
  vim.b.lsp_diagnostic_indicators_mode = 'SignsVirtualText'
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
  	  signs = true,
  	  virtual_text = true,
  	  underline = false,
      update_in_insert = false,
    }
  )
end

-- Toggle diagnostics
function _G.lsp_diagnostic_indicators_toggle()
  if vim.b.lsp_diagnostic_indicators_show then
	lsp_diagnostic_indicators_clear()
	lsp_diagnostic_indicators_disable()
    vim.b.lsp_diagnostic_indicators_show = false
  else
	lsp_diagnostic_indicators_signsvirtualtext()
	lsp_diagnostic_indicators_redraw()
    vim.b.lsp_diagnostic_indicators_show = true
  end
end

vim.b.lsp_diagnostic_indicators_show = false
lsp_diagnostic_indicators_disable()
