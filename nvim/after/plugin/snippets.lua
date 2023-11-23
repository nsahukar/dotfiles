local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

ls.config.set_config {
  -- This tells luasnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection.
  history = true,

  -- This one is cool cause if you have dynamic snippets,
  -- it updates as you type!
  updateevents = 'TextChanged,TextChangedI'
}

local opts = {noremap = true, silent = true}

-- Expansion key
-- This will expand the current item or
-- jump to the next item within the snippet
vim.keymap.set({ 'i', 's' }, '<M-n>', function ()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, opts)

-- Jump back key
-- This always move to the previous item within the snippet
vim.keymap.set({ 'i', 's' }, '<M-p>', function ()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, opts)

-- Selecting within a list of options
-- This is useful for choice nodes
vim.keymap.set('i', '<M-l>', function ()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, opts)


-- SNIPPETS
--
-- go
ls.add_snippets('go', {
  s('enn', fmt("if err != nil {{\n\t{}\n}}", { i(0) })),
  s('haf', fmt("func {}(w http.ResponseWriter, r *http.Request) {{\n\t{}\n}}", { i(1), i(0) })),
  s('tes', fmt("func Test{}(t *testing.T) {{\n\t{}\n}}", { i(1), i(0) })),
})
