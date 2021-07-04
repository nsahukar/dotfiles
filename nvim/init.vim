" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" *** BASIC ***
"
" Map leader key to space
let mapleader = " "

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" Turn on smart indentation
set smartindent

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Stop the highlighting (incsearch)
map <leader>h :noh<CR>

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
" set mouse+=a

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>


" *** TAB AND SPACES ***
"
set tabstop=4		" Size of a hard tabstop (ts)
set shiftwidth=4	" Size of an indentation (sw)
set noexpandtab		" Always use tabs instead of space charaters (noet)
set autoindent		" Copy indent from current line when starting a new line (ai)


" *** PLUGINS ***
"
" Specify a directory for plugins
call plug#begin(stdpath('data') . '/plugged')


" Lightline
Plug 'itchyny/lightline.vim'

" Nord Color Scheme
Plug 'arcticicestudio/nord-vim'

" LSP (Native)
Plug 'neovim/nvim-lspconfig'
" Compe (Auto Completion)
Plug 'hrsh7th/nvim-compe'
" Vsnip (VSCode LSPs' snippet feature)
Plug 'hrsh7th/vim-vsnip'
" Show function signature
Plug 'ray-x/lsp_signature.nvim'
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Golang
Plug 'golang/vscode-go'

" Telescope (Extendable fuzzy finder)
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Dev Icons (nvim)
Plug 'kyazdani42/nvim-web-devicons'

" Initialize plugin system
call plug#end()


" *** LIGHTLINE ***
"
" performance optimization
set ttimeout ttimeoutlen=50
" disabling showing default vim modes
set noshowmode
" colorscheme
let g:lightline = {
	\'colorscheme': 'darcula',
	\}


" *** COLOR SCHEME ***
"
colorscheme nord


" *** LANGUAGES INTELLISENSE AND AUTOCOMPLETION ***
"
" lsp
luafile ~/.config/nvim/plug/lang/lsp/conf.lua

" compe
luafile ~/.config/nvim/plug/lang/compe/conf.lua
" inoremap <silent><expr> <C-Space> compe#complete()
" inoremap <silent><expr> <CR>      compe#confirm('<CR>')
" inoremap <silent><expr> <C-e>     compe#close('<C-e>')
" inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
" inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
set shortmess+=c

" vsnip
" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}

" treesitter
luafile ~/.config/nvim/plug/lang/treesitter/conf.lua

" golang
luafile ~/.config/nvim/plug/lang/go/conf.lua
autocmd BufWritePre *.go lua goimports(1000)


" *** TELESCOPE ***
"
luafile ~/.config/nvim/plug/telescope/conf.lua


" *** CUSTOM COMMANDS ***
"
" Telescope
:command -nargs=1 -complete=buffer Rg :Telescope grep_string search=<args>

function! FindFiles(cwd)
	if len(a:cwd) == 0
		exe ":Telescope find_files"
	else
		exe ":Telescope find_files cwd=" . a:cwd
	endif
endfunction

:command -nargs=? -complete=dir Files call FindFiles(<q-args>)
