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
noremap <M-i> ^
noremap <M-a> $

" Mapping to move lines
nnoremap <silent><M-j> :m .+1<CR>==
nnoremap <silent><M-k> :m .-2<CR>==
inoremap <silent><M-j> <Esc>:m .+1<CR>==gi
inoremap <silent><M-k> <Esc>:m .-2<CR>==gi
vnoremap <silent><M-j> :m '>+1<CR>gv=gv
vnoremap <silent><M-k> :m '<-2<CR>gv=gv

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

" Changing default split behavior
set splitbelow splitright

" Remapping resizing split windows
nnoremap <C-Down> <C-w>-
nnoremap <C-Up> <C-w>+
nnoremap <C-Left> <C-w>>
nnoremap <C-Right> <C-w><

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

set tabstop=4		" Size of a hard tabstop (ts)
set shiftwidth=4	" Size of an indentation (sw)
set noexpandtab		" Always use tabs instead of space charaters (noet)
set autoindent		" Copy indent from current line when starting a new line (ai)
" custom tabs for languages
augroup tabs_lang
	au!
	au BufRead,BufNewFile *.lua,*.html,*.js setlocal tabstop=2
	au BufRead,BufNewFile *.lua,*.html,*.js setlocal shiftwidth=2
augroup END


" *** PLUGINS ***

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')


" Lightline
Plug 'itchyny/lightline.vim'

" Tender
Plug 'jacoborus/tender.vim'

" FZF
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Fern
Plug 'lambdalisue/fern.vim'


" Initialize plugin system
call plug#end()


" *** LIGHTLINE ***

" performance optimization
set ttimeout ttimeoutlen=50
" disabling showing default vim modes
set noshowmode
" colorscheme
let g:lightline = {
	\'colorscheme': 'darcula',
	\}


" *** COLOR SCHEME ***

colorscheme tender


" *** FZF ***

" Rg customization: including hidden files except .git
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden -g "!.git" --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)


" " *** FERN ***
" 
" " Disable netrw.
let g:loaded_netrw  = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

" Using Nerdfont as font renderer
let g:fern#renderer = "nerdfont"

" Layout
noremap <silent><Leader>e :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=

" Custom settings and mappings.
" let g:fern#disable_default_mappings = 1

function! s:init_fern() abort
  " Use 'select' instead of 'edit' for default 'open' action
  nmap <buffer> <Plug>(fern-action-open) <Plug>(fern-action-open:select)
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> M <Plug>(fern-action-rename)
  nmap <buffer> H <Plug>(fern-action-hidden-toggle)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> x <Plug>(fern-action-mark:toggle)
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END
