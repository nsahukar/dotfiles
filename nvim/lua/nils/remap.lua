local nnoremap = require('nils.keymap').nnoremap
local vnoremap = require('nils.keymap').vnoremap
local xnoremap = require('nils.keymap').xnoremap
local inoremap = require('nils.keymap').inoremap
local tnoremap = require('nils.keymap').tnoremap
local terminal = require('nils.terminal')

-- BASIC
--
-- Move lines
nnoremap('<M-k>', ':m .-2<CR>==')
nnoremap('<M-j>', ':m .+1<CR>==')
vnoremap("<M-j>", ":m '>+1<CR>gv=gv")
vnoremap("<M-k>", ":m '<-2<CR>gv=gv")

-- Switching between tabs
nnoremap('<M-Tab>', ':tabnext<CR>')
nnoremap('<S-Tab>', ':tabprev<CR>')

-- Moving around split windows
nnoremap('<C-h>', '<C-w>h')
nnoremap('<C-j>', '<C-w>j')
nnoremap('<C-k>', '<C-w>k')
nnoremap('<C-l>', '<C-w>l')

-- Copy, paste from system clipboard, using '+' register here
vnoremap('<leader>y', '"+y')
nnoremap('<leader>p', '"+p')
-- Do not register the selection in clipboard
-- when pasting on it
xnoremap('<M-p>', '"_dP')
-- Move the cursor to the end of selection after a yank
vnoremap('y', 'ygv<ESC>')

-- Delete current word in insert mode
inoremap('<M-BS>', '<C-w>')
-- Stop highlighting (search)
nnoremap('<leader><leader>', ':noh<CR>')

-- Do not show command window or search window
-- on following keybindings
nnoremap('q:', '')
nnoremap('q/', '')


-- PLUGINS
--
-- NvimTree
--
-- Toggle nvim-tree
nnoremap('<leader>e', ':NvimTreeToggle<CR>')

-- Telescope
--
-- Telescope: find files
nnoremap('<leader>ff', ':Telescope find_files<CR>')
-- Telescope: find buffers
nnoremap('<leader>fb', ':Telescope buffers<CR>')
-- Telescope: find help
nnoremap('<leader>h', ':Telescope help_tags<CR>')


-- TERMINAL
--
-- Remapping <ESC> to exit
tnoremap('<ESC>', '<C-\\><C-n>')
-- Toggle terminal
nnoremap('<leader>t', terminal.toggle_terminal)
