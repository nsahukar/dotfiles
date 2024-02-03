-- vim.g -> global editor variables
-- vim.o -> get or set editor options
local g = vim.g
local o = vim.o

-- GLOBAL

-- Map <leader> to space
g.mapleader = ' '



-- EDITOR OPTIONS
--
-- Use TUI colors
o.termguicolors = true

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 8

-- Show line numbers
o.number = true
-- This enables relative line numbering mode. With both number and
-- relativenumber enabled, the current line shows the true line number, while
-- all other lines (above and below) are numbered relative to the current line.
-- This is useful because you can tell, at a glance, what count is needed to
-- jump up or down to a particular line, by {count}k to go up or {count}j to go
-- down.
o.relativenumber = true
-- Minimal number of columns to use for line number
o.numberwidth = 4

-- Have a global status line at the bottom instead of one for each window
o.laststatus = 3


-- TABS AND INDENTATIONS
--
-- Number of spaces that a <Tab> in the file counts for
o.tabstop = 4
-- If shiftwidth equals 0, use tabstop value
o.shiftwidth = 0
-- Expand tabs to spaces
o.expandtab = true
-- C indenting rules
o.cindent = true
-- Copy indent from current line when starting a new line
o.autoindent = true


-- SEARCH
--
-- Enable searching as you type, rather than waiting till you press enter.
o.incsearch = true
-- This setting makes search case-insensitive when all characters in the string
-- being searched are lowercase. However, the search becomes case-sensitive if
-- it contains any capital letters. This makes searching more convenient.
o.ignorecase = true
o.smartcase = true


-- SPLIT
--
-- Change default split behaviour
o.splitbelow = true 
o.splitright = true


-- BACKUP AND UNDO
--
-- No backup mode
o.backup = false
o.writebackup = false
-- Use undo file and no swap file
o.undofile = true
o.swapfile = false


-- HISTORY
--
-- Remember 30 items in command line history
o.history = 30

-- Enable mouse support. You should avoid relying on this too much, but it can
-- sometimes be convenient.
o.mouse = 'a'
