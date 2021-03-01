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
set nocompatible
color evening
set background=dark
let mapleader=" "
set autoindent tabstop=4 softtabstop=4 shiftwidth=4
set cursorline  wildmenu "visual command completion menu
set path+=/home/buggy
set clipboard=unnamedplus
set incsearch nohlsearch ignorecase smartcase
set nospell spelllang=en_gb
set title
set nolist listchars=eol:$,tab:\|\ >,trail:~,space:+
syntax enable
filetype plugin on

"general appearance
hi Normal guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE
hi CursorLine guibg=#333343 term=NONE cterm=NONE
hi EndOfBuffer guibg=NONE
