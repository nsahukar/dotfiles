local nnoremap = require('nils.keymap').nnoremap
local vnoremap = require('nils.keymap').vnoremap
local inoremap = require('nils.keymap').inoremap

-- BASIC
--
-- Move lines
nnoremap('<M-j>', ':m .+1<CR>==')
nnoremap('<M-k>', ':m .-2<CR>==')
vnoremap("<M-j>", ":m '>+1<CR>gv=gv")
vnoremap("<M-k>", ":m '<-2<CR>gv=gv")
-- Switching between tabs
nnoremap('<Tab>', ':tabnext<CR>')
nnoremap('<S-Tab>', ':tabprev<CR>')
-- Moving around split windows
nnoremap('<C-h>', '<C-w>h')
nnoremap('<C-j>', '<C-w>j')
nnoremap('<C-k>', '<C-w>k')
nnoremap('<C-l>', '<C-w>l')
-- Copy, paste from system clipboard, using '+' register here
nnoremap('<leader>y', '"+y')
nnoremap('<leader>p', '"+p')
-- Delete current word in insert mode
inoremap('<M-BS>', '<C-w>')
-- Stop highlighting (search)
nnoremap('<leader><leader>', ':noh<CR>')


-- PLUGINS
-- 
-- Toggle nvim-tree
nnoremap('<leader>e', ':NvimTreeToggle<CR>')
-- Telescope: find files
nnoremap('<leader>ff', ':Telescope find_files<CR>')
-- Telescope: find buffers
nnoremap('<leader>fb', ':Telescope buffers<CR>')
-- Telescope: find help
nnoremap('<leader>h', ':Telescope help_tags<CR>')
