local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <C-x><C-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    local bufopts = { noremap = true, silent = true, buffer = bufnr, desc = desc }
    vim.keymap.set('n', keys, func, bufopts)
  end

  local imap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    local bufopts = { noremap = true, silent = true, buffer = bufnr, desc = desc }
    vim.keymap.set('i', keys, func, bufopts)
  end

  -- Mappings
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gt', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')
  nmap('gi', vim.lsp.buf.implementation, 'List all implementation(s) in quickfix window')
  nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
  imap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  nmap('<leader>n', vim.lsp.buf.rename, 'Re[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('<leader>f', vim.lsp.buf.format, '[F]ormat')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  nmap('<leader>d', vim.diagnostic.open_float, 'Show [D]iagnostic')
  nmap('[d', vim.diagnostic.goto_prev, 'Goto Previous [D]iagnostic')
  nmap(']d', vim.diagnostic.goto_next, 'Goto Next [D]iagnostic')
  nmap('<leader>q', vim.diagnostic.setloclist, 'Show [Q]uickfix list')
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
    config.filetypes = { "html", "gohtml", "css", "sass", "scss", "less" }
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
