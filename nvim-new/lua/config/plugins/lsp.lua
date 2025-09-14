return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- "williamboman/mason.nvim",
      -- "williamboman/mason-lspconfig.nvim",
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    opts = {
      servers = {
        lua_ls = {},
        gopls = {},
        pyright = {},
        ts_ls = {},
        emmet_language_server = {},
      }
    },
    config = function(_, opts)
      -- require('mason').setup()
      -- local mason_lspconfig = require('mason-lspconfig')
      -- mason_lspconfig.setup {
      --   ensure_installed = {
      --     "lua_ls",
      --     "gopls",
      --   }
      -- }

      local lspconfig = require('lspconfig')
      for server, config in pairs(opts.servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities()
        config.on_attach = function(_, bufnr)
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
          vim.keymap.set('n', 'ca', vim.lsp.buf.code_action, bufopts)
          vim.keymap.set('n', 'sd', vim.diagnostic.open_float, bufopts)
        end
        lspconfig[server].setup(config)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client.supports_method('textDocument/formatting') then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end
            })
          end
          -- if client.supports_method('textDocument/rename') then
          --   -- Create a keymap for vim.lsp.buf.rename()
          -- end
          -- if client.supports_method('textDocument/implementation') then
          --   -- Create a keymap for vim.lsp.buf.implementation
          -- end
        end,
      })
    end
  }
}
