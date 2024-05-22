local M = {}

M.has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.config = function()
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  local lspkind = require('lspkind')
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i',  'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        select = false
      }),

      ['<M-n>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { "i", "s" }),

      ['<M-p>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { "i", "s" }),

      -- ['<Tab>'] = cmp.mapping(function(fallback)
      --   -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
      --   -- that way you will only jump inside the snippet region
      --   if luasnip.expand_or_jumpable() then
      --     luasnip.expand_or_jump()
      --   elseif M.has_words_before() then
      --     cmp.complete()
      --   else
      --     fallback()
      --   end
      -- end, { "i", "s" }),
      --
      -- ['<S-Tab>'] = cmp.mapping(function(fallback)
      --   if luasnip.jumpable(-1) then
      --     luasnip.jump(-1)
      --   else
      --     fallback()
      --   end
      -- end, { "i", "s" }),
    },

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'path' },
      { name = 'buffer', keyword_length = 3 },
    }),

    formatting = {
      format = lspkind.cmp_format {
        with_text = true,
        menu = {
          nvim_lsp = "[LSP]",
          luasnip = "[snip]",
          path = "[path]",
          buffer = "[buf]",
        },
      },
    },

    preselect = cmp.PreselectMode.None,

    experimental = {
      native_menu = false,
      -- ghost_text = true,
    },
  })

  -- Set configuration for specific filetype
  cmp.setup.filetype('lua', {
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'luasnip' },
    }, {
      { name = 'path' },
      { name = 'buffer', keyword_length = 3 },
    })
  })
end

M.cmp = {
  -- completion engine
  "hrsh7th/nvim-cmp",
  name = "cmp",
  dependencies = {
    -- Snippet engine
    { "L3MON4D3/LuaSnip", version = "v2.*" },
    -- adds vscode-like pictograms to native LSP
    "onsails/lspkind-nvim",
  },
  config = M.config,
}

M.cmp_lsp = {
  -- nvim-cmp source for native LSP client
  "hrsh7th/cmp-nvim-lsp",
  dependencies = "cmp",
}

M.cmp_lua = {
  -- nvim-cmp source for neovim lua API
  "hrsh7th/cmp-nvim-lua",
  dependencies = "cmp",
}

M.cmp_buffer = {
  -- nvim-cmp source for buffer words
  "hrsh7th/cmp-buffer",
  dependencies = "cmp",
}

M.cmp_path = {
  -- nvim-cmp source for filesystem paths
  "hrsh7th/cmp-path",
  dependencies = "cmp",
}

M.cmp_luasnip = {
  -- nvim-cmp source for luasnip
  "saadparwaiz1/cmp_luasnip",
  dependencies = "cmp",
}

return {
  M.cmp,
  M.cmp_lsp,
  M.cmp_lua,
  M.cmp_buffer,
  M.cmp_path,
  M.cmp_luasnip,
}
