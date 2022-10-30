local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

local nnoremap = function(lhs, rhs, opts)
  vim.keymap.set('n', lhs, rhs, opts)
end

local inoremap = function(lhs, rhs, opts)
  vim.keymap.set('i', lhs, rhs, opts)
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
  inoremap('<C-k>', vim.lsp.buf.signature_help, bufopts)
  nnoremap('<leader>n', vim.lsp.buf.rename, bufopts)
  nnoremap('<leader>ca', vim.lsp.buf.code_action, bufopts)
  nnoremap('<leader>f', vim.lsp.buf.formatting, bufopts)

  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { noremap = true, silent = true }
  nnoremap('<leader>d', vim.diagnostic.open_float, opts)
  nnoremap('[d', vim.diagnostic.goto_prev, opts)
  nnoremap(']d', vim.diagnostic.goto_next, opts)
  nnoremap('<leader>q', vim.diagnostic.setloclist, opts)
end


-- `cmp-nvim-lsp` -> enhancing client's capability to make use of more (different)
--                   completion results (candidates) provided by different
--                   language servers.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())


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

  -- denols (deno language server)
  -- install: sudo pacman -S deno
  'denols',

  -- tsserver (typescript language server)
  -- install: npm install -g typescript typescript-language-server
  -- 'tsserver',

  -- emmet_ls (underscore)
  -- install: npm install -g emmet-ls (hypen)
  'emmet_ls',

  -- volar (vue language server)
  -- install: npm install -g @volar/vue-language-server
  -- 'volar',
}

for _, lang_server in ipairs(servers) do
  local config = {}

  -- specific language server setup
  if lang_server == 'emmet_ls' then
    config.filetypes = { "html", "gohtmltmpl", "css", "sass", "scss", "less" }
  elseif lang_server == 'volar' then
    config.filetypes = { "vue", "javascript" }
    config.root_dir = util.root_pattern("package.json", ".git/")
  end

  -- general language server(s) setup
  config.on_attach = on_attach
  config.capabilities = capabilities

  -- apply user config
  lspconfig[lang_server].setup(config)
end


-- turn off virtual_text and underline handlers for diagnistics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  underline = false,
})
