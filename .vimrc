call plug#begin('~/.vim/bundle')
"Plugin manager
	Plug 'junegunn/vim-plug'
"Nord colorscheme
	Plug 'arcticicestudio/nord-vim'
"lean statusbar
	Plug 'vim-airline/vim-airline'
"themes for the smae
	Plug 'vim-airline/vim-airline-themes'
"tpope's defaults
	Plug 'tpope/vim-sensible'
"commenting toggle plugin
	Plug 'tpope/vim-commentary'
"another helpful tpope plugin
	Plug 'tpope/vim-surround'
"git plugin by tpope again
	Plug 'tpope/vim-fugitive'
"allows seamless navigation b/w vim and tmux panes
	Plug 'christoomey/vim-tmux-navigator'
"colorize hex codes
	Plug 'chrisbra/Colorizer'
"Latex plugin for vim
	Plug 'lervag/vimtex'
"Visual file tree plugin
	Plug 'scrooloose/nerdTree'
"pywal colorscheme enable
	Plug 'dylanaraps/wal.vim'
" <C-v> <C-a> to increment a visual block
	Plug 'triglav/vim-visual-increment'
"Solarized theme for vim
	Plug 'lifepillar/vim-solarized8'
"Loads of vim colorschemes
	Plug 'flazz/vim-colorschemes'
"Asynchronous linting engine
	Plug 'dense-analysis/ale'
call plug#end()

"true color terminals
if exists('+termguicolors')
	let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" UTF-8 support
if exists('+multi_byte')
	scriptencoding utf-8
	set encoding=utf-8
endif

"general settings
set background=dark
colo nord
let mapleader=" "
set number
set relativenumber
set autoindent
set tabstop=4
set shiftwidth=4
set cursorline
set wildmenu "visual command completion menu
set path+=** "set vim to recursively look through subdirectories when dealing with file paths
set clipboard=unnamedplus
set incsearch
set ignorecase
set smartcase
set spell
set title
set nolist
set listchars=eol:$,tab:\|\ >,trail:~,space:+
syntax enable
set cm=blowfish2
filetype plugin on
set omnifunc=syntaxcomplete#Complete

"General remaps
inoremap <M-Space> <ESC>
inoremap jj <ESC>
nmap <leader>n :NERDTreeToggle<CR>
tmap <leader><ESC> <C-\><C-n>
tmap <M-Space> <C-\><C-n>
nmap <leader>l :set list!<CR>
nmap <leader>z z=1<CR><CR>

"nord-vim customizations
let g:nord_bold = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_cursor_line_number_background = 1
let g:nord_uniform_diff_background = 1

"solarized customizations
let g:solarized_termtrans = 1
let g:solarized_termcolors = 256

"airline settings
let g:airline#extensions#whitespace#checks =
\  [ 'indent', 'trailing', 'conflicts' ]

"ALE settings
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1

"LaTeX
let g:tex_flavor = 'latex'

"markdown
let g:markdown_fenced_languages =
	\ ['bash', 'c', 'asm', 'lua', 'python', 'html', 'css']
let g:vim_markdown_math = 1

