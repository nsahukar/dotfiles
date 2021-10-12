" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" *** BASIC ***
"
" Map leader key to space
let mapleader = " "

" Use TUI colors
set termguicolors

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
map <silent><leader>h :noh<CR>

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

" Remapping to delete current word in insert mode
inoremap <M-BS> <C-w>

" Simple copy, paste from system clipboard, using '+' register here
map <leader>y "+y
map <leader>p "+p

" Remapping beginning of line, end of line
noremap <M-a> ^
noremap <M-i> $

" Mapping to move lines
nnoremap <silent><M-j> :m .+1<CR>==
nnoremap <silent><M-k> :m .-2<CR>==
inoremap <silent><A-j> <Esc>:m .+1<CR>==gi
inoremap <silent><A-k> <Esc>:m .-2<CR>==gi
vnoremap <silent><A-j> :m '>+1<CR>gv=gv
vnoremap <silent><A-k> :m '<-2<CR>gv=gv

" Mapping switching between tabs
nnoremap <silent><Tab> :tabnext<CR>
nnoremap <silent><S-Tab> :tabprev<CR>
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

" Remapping resizing split windows
nnoremap <M-j> <C-w>-
nnoremap <M-k> <C-w>+
nnoremap <M-h> <C-w>>
nnoremap <M-l> <C-w><

" Ramapping moving around split windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" CursorLine highlight applied in current window only
augroup cursor_line
	au!
	au VimEnter,WinEnter,BufEnter * setlocal cursorline
	au Winleave * setlocal nocursorline
augroup END


" *** TAB AND SPACES ***
"
" general
set tabstop=4		" Size of a hard tabstop (ts)
set shiftwidth=4	" Size of an indentation (sw)
set noexpandtab		" Always use tabs instead of space charaters (noet)
set autoindent		" Copy indent from current line when starting a new line (ai)
set smartindent 	" Smart auto-indenting for programs
" lua
augroup tabs_lang
	au!
	au BufRead,BufNewFile *.lua,*.html,*.js setlocal tabstop=2
	au BufRead,BufNewFile *.lua,*.html,*.js setlocal shiftwidth=2
augroup END


" *** PLUGINS ***
"
" Specify a directory for plugins
call plug#begin(stdpath('data') . '/plugged')


" Lightline
Plug 'itchyny/lightline.vim'

" Iceberg colorscheme
Plug 'cocopon/iceberg.vim'
" Jellybeans colorscheme
Plug 'metalelf0/jellybeans-nvim'
" Lush (Colorscheme creation aid)
Plug 'rktjmp/lush.nvim'

" LSP (Native)
Plug 'neovim/nvim-lspconfig'
" Vsnip (VSCode LSPs' snippet feature)
Plug 'hrsh7th/vim-vsnip'
" Cmp (A completion engine)
Plug 'hrsh7th/nvim-cmp'
" Cmp-nvim-lsp (nvim-cmp source for neovim LSP)
Plug 'hrsh7th/cmp-nvim-lsp'
" Cmp-vsnip (nvim-cmp source for vim-vsnip)
Plug 'hrsh7th/cmp-vsnip'
" Cmp-buffer (nvim-cmp source for buffer words)
Plug 'hrsh7th/cmp-buffer'
" Cmp-path (nvim-cmp source for filesystem paths)
Plug 'hrsh7th/cmp-path'
" Show function signature
Plug 'ray-x/lsp_signature.nvim'
" ALE (Asynchronous Lint Engine)
Plug 'dense-analysis/ale'
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Toggle comments in neovim
Plug 'terrortylor/nvim-comment'
" Golang
Plug 'golang/vscode-go'

" Telescope (Extendable fuzzy finder)
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Dev Icons (nvim)
Plug 'kyazdani42/nvim-web-devicons'

" VimWiki
Plug 'vimwiki/vimwiki'


" Initialize plugin system
call plug#end()


" *** LIGHTLINE ***
"
" performance optimization
set ttimeout ttimeoutlen=50
" disabling showing default vim modes
set noshowmode
" mods
let g:lightline = {
    \ 'colorscheme': 'darcula',
	\ 'active': {
	\ 	'left': [ [ 'mode', 'paste' ],
	\ 			  [ 'readonly', 'filename', 'modified' ] ]
	\ },
 	\ 'component': {
 	\   'lineinfo': '%3l:%-2v',
 	\ },
 	\ 'component_function': {
 	\   'readonly': 'LightlineReadonly',
 	\   'fugitive': 'LightlineFugitive',
 	\ },
 	\ 'separator': { 'left': '', 'right': '' },
 	\ 'subseparator': { 'left': '⏐', 'right': '⏐' }
 	\ }
function! LightlineReadonly()
	return &readonly ? '' : ''
endfunction
function! LightlineFugitive()
	if exists('*FugitiveHead')
		let branch = FugitiveHead()
		return branch !=# '' ? ''.branch : ''
	endif
	return ''
endfunction


" *** COLOR SCHEME ***
"
colorscheme jellybeans-nvim

" Minor color adjustments
"
" |- normal
hi Normal guibg=#131313
" |- cursorline
hi CursorLine guibg=#191919
" |- pmenu
hi Pmenu guibg=#212121 guifg=#AFA89D
" |- pmenusel
hi PmenuSel guibg=#C6B6EE guifg=#000000


" *** LANGUAGE SERVERS, AUTOCOMPLETION, LINTERS AND FIXERS ***
"
" lsp
luafile ~/.config/nvim/plug/lang/lsp/conf.lua
nnoremap <silent> <leader>dd :lua lsp_diagnostic_indicators_toggle()<CR>

" cmp
set completeopt=menu,menuone,noselect
luafile ~/.config/nvim/plug/lang/cmp/conf.lua
" set shortmess+=c

" vsnip
" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}

" ALE
let g:ale_fixers = ['prettier', 'eslint']
let g:ale_linters_explicit = 1

" treesitter
luafile ~/.config/nvim/plug/lang/treesitter/conf.lua

" golang
luafile ~/.config/nvim/plug/lang/go/conf.lua
autocmd BufWritePre *.go lua goimports(1000)


" *** TELESCOPE ***
"
luafile ~/.config/nvim/plug/telescope/conf.lua

" |- cmd:  Rg <search-string>
"    pre:  'ripgrep' needed to be installed.
"    desc: Configuring telescope 'grep_string' to specific needs.
command -nargs=1 -complete=buffer Rg :Telescope grep_string search=<args>

" |- cmd:  Files [current-working-directory]
" 	 desc: Configuring telescope 'find_files' to specific needs.
" 	 	   Now takes optional current working directory.
function! FindFiles(cwd)
	if len(a:cwd) == 0
		exe ":Telescope find_files"
	else
		exe ":Telescope find_files cwd=" . a:cwd
	endif
endfunction

command -nargs=? -complete=dir Files call FindFiles(<q-args>)


" *** COMMENT ***
"
luafile ~/.config/nvim/plug/comment/conf.lua
" set commentstring
" cpp
augroup set_commentstring_cpp
	au!
	au BufEnter *.cpp,*.h :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
augroup END


" *** VIMWIKI ***
"
" custom path and index
let g:vimwiki_list = [{'path': '~/Documents/todos/', 'index': 'launchpad'}]

" modified textwidth for vimwiki buffers
autocmd BufRead,BufNewFile *.wiki setlocal textwidth=36

" |- cmd:  <leader>ww
" 	 desc: Remapping default <leader>ww in vimwiki plugin.
" 	       Now opens in vertical split 40% right side. 
let todoIndex = "~/Documents/todos/launchpad.wiki"

function! GetWikiBufs()
	 return join(map(filter(range(1, bufnr('$')), 'buflisted(v:val) && bufname(v:val) =~ ".*\\.wiki"'), {_, val -> bufname(val)}), " ")
endfunction

function! OpenTodosDrawer()
	exe ":rightb 40vsplit " . g:todoIndex
endfunction

function! CloseTodosDrawer(todoBufs)
	exe "bd! " . a:todoBufs
endfunction

function! ToggleTodosDrawer()
	let todoBufs = GetWikiBufs()
	if len(todoBufs) > 0
		call CloseTodosDrawer(todoBufs)
	else
		call OpenTodosDrawer()
	endif
endfunction

nnoremap <silent> <leader>ww :call ToggleTodosDrawer()<CR>

" overriding 'VimwikiLinkHandler' to open always
" open file in new tab.
function! VimwikiLinkHandler(link)
  let link = a:link
  if link !~# '^file:'
    return 0
  endif
  let link_infos = vimwiki#base#resolve_link(link)
  if link_infos.filename == ''
    echomsg 'Vimwiki Error: Unable to resolve link!'
    return 0
  else
    exe 'tabnew ' . fnameescape(link_infos.filename)
    return 1
  endif
endfunction


" *** TERMINAL ***
"
" remapping ESC in terminal mode to exit terminal mode
tnoremap <Esc> <C-\><C-n>

" |- cmd:  <leader>t
" 	 desc: Mapping <leader>t to toggle terminal.
" 	 	   Opens in horizontal split below current window. Size 24.
function! GetTermBufs()
	 return join(map(filter(range(1, bufnr('$')), 'buflisted(v:val) && bufname(v:val) =~ "term"'), {_, val -> bufname(val)}), " ")
endfunction

function! OpenTerminal(termBufs)
	if len(a:termBufs) == 0
		exe "rightb 24split term://fish"
	else
		exe "rightb 24split buffer " . a:termBufs
	endif
endfunction

function! CloseTerminal(termBufs)
	exe "bd! " . a:termBufs
endfunction

function! ToggleTerminal()
	let termBufs = GetTermBufs()
	if len(termBufs) > 0 
		call CloseTerminal(termBufs)
	else
		call OpenTerminal(termBufs)
	endif
endfunction

nnoremap <silent> <leader>t :call ToggleTerminal()<CR>
