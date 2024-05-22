local nnoremap = require('nijk.keymap').nnoremap
local vnoremap = require('nijk.keymap').vnoremap
local xnoremap = require('nijk.keymap').xnoremap
local inoremap = require('nijk.keymap').inoremap
local tnoremap = require('nijk.keymap').tnoremap
local terminal = require('nijk.terminal')

-- BASIC
--
-- Move lines
-- nnoremap('<M-k>', ':m .-2<CR>==')
-- nnoremap('<M-j>', ':m .+1<CR>==')
vnoremap("<M-j>", ":m '>+1<CR>gv=gv")
vnoremap("<M-k>", ":m '<-2<CR>gv=gv")

-- Switching between tabs
-- nnoremap('<M-Tab>', ':tabnext<CR>')
nnoremap('<S-Tab>', ':tabprev<CR>')

-- Moving around split windows
nnoremap('<M-h>', '<C-w>h')
nnoremap('<M-j>', '<C-w>j')
nnoremap('<M-k>', '<C-w>k')
nnoremap('<M-l>', '<C-w>l')

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
nnoremap('q:', '<nop>')
nnoremap('q/', '<nop>')


-- TERMINAL
--
-- Remapping <ESC> to exit
tnoremap('<ESC>', '<C-\\><C-n>')
-- Toggle terminal
nnoremap('<leader>t', terminal.toggle_terminal)


-- PLUGINS
--
-- NvimTree
--
-- Toggle nvim-tree
-- nnoremap('<leader>e', ':NvimTreeToggle<CR>')

-- Telescope
--
-- Telescope: find files
-- nnoremap('<leader>ff', ':Telescope find_files<CR>')
-- Telescope: find buffers
-- nnoremap('<leader>fb', ':Telescope buffers<CR>')
-- Telescope: find help
-- nnoremap('<leader>h', ':Telescope help_tags<CR>')
