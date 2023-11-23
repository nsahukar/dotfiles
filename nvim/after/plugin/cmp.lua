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
			behavior = cmp.ConfirmBehavior.Replace,
			select = false 
		}),

		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),

		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
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
