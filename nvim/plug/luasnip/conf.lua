local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt
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

-- -- This will expand the current item or
-- -- jump to the next item within the snippet.
-- function snip_expand_or_jump()
-- 	if ls.expand_or_jumpable() then
-- 		ls.expand_or_jump()
-- 	end
-- end
--
-- -- This will move to the previous item within the snippet
-- function snip_jump_back()
-- 	if ls.jumpable(-1) then
-- 		ls.jump(-1)
-- 	end
-- end
--
-- -- This is useful for choice nodes
-- function snip_change_choice()
-- 	if ls.choice_active() then
-- 		ls.change_choice(1)
-- 	end
-- end
--
-- local opts = { noremap=true, silent=true }
-- -- Expansion key
-- vim.api.nvim_set_keymap("i", "<M-j>", "<CMD>lua snip_expand_or_jump()<CR>", opts)
-- -- Jump back key
-- vim.api.nvim_set_keymap("i", "<M-k>", "<cmd> lua snip_jump_back()<CR>", opts)
-- -- Selecting within a list of options
-- vim.api.nvim_set_keymap("i", "<M-l>", "<cmd> lua snip_change_choice()<CR>", opts)

-- Expansion key
-- This will expand the current item or jump to the next item within the snippet
vim.keymap.set({ "i", "s" }, "<M-n>", function ()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, opts)

-- Jump back key
-- This always move to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<M-p>", function ()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, opts)

-- Selecting within a list of options
-- This is useful for choice nodes
vim.keymap.set("i", "<M-l>", function ()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, opts)


-- SNIPPETS
ls.add_snippets("all", {
	s("exp", { t("-- This is what was expanded!") })
})

ls.add_snippets("lua", {
	s("fn", fmt("local {} = function({})\n\t{}\nend", { i(1), i(2), i(0) })),
})

ls.add_snippets("go", {
	s("enn", fmt("if err != nil {{\n\t{}\n}}", { i(0) })),
	s("haf", fmt("func {}(w http.ResponseWriter, r *http.Request) {{\n\t{}\n}}", { i(1), i(0) })),
})
