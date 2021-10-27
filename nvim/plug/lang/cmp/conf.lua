local cmp = require'cmp'
local lspkind = require'lspkind'

cmp.setup({
	snippet = {
		expand = function(args)
			-- For `vsnip` user
		  -- vim.fn["vsnip#anonymous"](args.body)

			-- For `luasnip` user
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = {
		['<C-j>'] = cmp.mapping.scroll_docs(-4),
		['<C-k>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		['<S-Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
	},
	sources = {
	  { name = 'nvim_lsp' },
		{ name = 'path' },
		{ name = 'luasnip' },
	  { name = 'buffer', keyword_length = 3 },
	},
	formatting = {
		format = lspkind.cmp_format {
			with_text = true,
			menu = {
				nvim_lsp = "[LSP]",
				path = "[path]",
				luasnip = "[snip]",
				buffer = "[buf]",
			},
		},
	},
	preselect = cmp.PreselectMode.None,
	experimental = {
		native_menu = false,
		ghost_text = true,
	},
})
