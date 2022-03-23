local ls = require('luasnip')
-- local types = require('luasnip.util.types')

ls.config.set_config {
	-- This tells Luasnip to remember to keep around the last snippet.
	-- You can jump back into it even if you move outside of the selection
	history = true,

	-- This one is cool cause if you have dynamic snippets, it updates as you type!
	updateevents = 'TextChanged,TextChangedI'

	-- Crazy highlights
	-- UPCOMING...
}

-- This will expand the current item or
-- jump to the next item within the snippet.
function snip_expand_or_jump()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end

-- This will move to the previous item within the snippet
function snip_jump_back()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end

-- This is useful for choice nodes
function snip_change_choice()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end

local opts = { noremap=true, silent=true }
-- Expansion key
vim.api.nvim_set_keymap("i", "<M-j>", "<CMD>lua snip_expand_or_jump()<CR>", opts)
-- Jump back key
vim.api.nvim_set_keymap("i", "<M-k>", "<cmd> lua snip_jump_back()<CR>", opts)
-- Selecting within a list of options
vim.api.nvim_set_keymap("i", "<M-l>", "<cmd> lua snip_change_choice()<CR>", opts)


-- SNIPPETS
ls.snippets = {
	all = {
		-- Available in any filetype
		ls.parser.parse_snippet("exp", "-- This is what was expanded!"),
	},

	lua = {
		ls.parser.parse_snippet("lf", "local $1 = function($2)\n  $0\nend")
	}
}
