local lspconfig = require('lspconfig')

local nnoremap = function(lhs, rhs, opts)
  vim.keymap.set('n', lhs, rhs, opts)
end

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <C-x><C-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  nnoremap('K', vim.lsp.buf.hover, bufopts)
  nnoremap('gD', vim.lsp.buf.declaration, bufopts)
  nnoremap('gd', vim.lsp.buf.definition, bufopts)
  nnoremap('gt', vim.lsp.buf.type_definition, bufopts)
  nnoremap('gi', vim.lsp.buf.implementation, bufopts)
  nnoremap('gr', vim.lsp.buf.references, bufopts)
  nnoremap('<C-k>', vim.lsp.buf.signature_help, bufopts)
  nnoremap('<leader>n', vim.lsp.buf.rename, bufopts)
  nnoremap('<leader>ca', vim.lsp.buf.code_action, bufopts)
  nnoremap('<leader>f', vim.lsp.buf.formatting, bufopts)

  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { noremap = true, silent = true }
  -- nnoremap('<leader>d', vim.diagnostic.open_float, opts)
  -- nnoremap('[d', vim.diagnostic.goto_prev, opts)
  -- nnoremap(']d', vim.diagnostic.goto_next, opts)
  nnoremap('<leader>q', vim.diagnostic.setloclist, opts)
end

-- `cmp-nvim-lsp` -> enhancing client's capability to make use of more (different)
--                   completion results (candidates) provided by different 
--                   language servers.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Configure following language servers with native LSP
local servers = { 
  -- gopls
  -- install: go install golang.org/x/tools/gopls@latest
  'gopls',
  
  -- lua-language-server
  -- install: sudo pacman -S lua-language-server
  'sumneko_lua',

  -- pyright
  -- install: python3 -m pip install --user --upgrade pyright
  'pyright',

  -- emmet_ls (underscore)
  -- install: npm install -g emmet-ls (hypen)
  'emmet_ls',
}
for _, lang_server in ipairs(servers) do
  lspconfig[lang_server].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
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

-- Disable diagnistic indicators BY DEFAULT
lsp_diagnostic_indicators_disable()
