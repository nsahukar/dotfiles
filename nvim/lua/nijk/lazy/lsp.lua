local M = {}

M.on_attach = function(_, bufnr)
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

M.config = function()
  require("mason").setup()
  local mason_lspconfig = require("mason-lspconfig")
  local lspconfig = require("lspconfig")
  -- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  mason_lspconfig.setup({
    ensure_installed = {
      "lua_ls",
      "gopls",
      "rust_analyzer",
      "pyright",
    },
  })

  for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
    local config = {}
    config.on_attach = M.on_attach
    config.capabilities = capabilities

    -- server specific configuration
    if server_name == "lua_ls" then
      config.settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
      }
    end

    lspconfig[server_name].setup(config)
  end

  -- turn off virtual_text and underline handlers for diagnistics
  -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  --   vim.lsp.diagnostic.on_publish_diagnostics, {
  --   virtual_text = false,
  --   underline = false,
  -- })
end

M.lsp = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "cmp",
  },
  config = M.config,
}

return M.lsp
