call plug#begin('~/.vim/bundle')
Plug 'junegunn/vim-plug' "Plugin manager
Plug 'arcticicestudio/nord-vim' "Nord colorscheme
Plug 'vim-airline/vim-airline' "lean statusbar
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-sensible' "tpope's defaults
Plug 'tpope/vim-commentary' "commenting toggle plugin
Plug 'tpope/vim-surround' "another helpful tpope plugin
Plug 'christoomey/vim-tmux-navigator' "allows seamless navigation b/w vim and tmux panes
Plug 'chrisbra/Colorizer' "colorize hex codes
Plug 'lervag/vimtex' "Latex plugin for vim
Plug 'scrooloose/nerdTree' "Visual file tree plugin
Plug 'dylanaraps/wal.vim' "pywal colorscheme enable
call plug#end()

"nord-vim customizations
let g:nord_bold = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_cursor_line_number_background = 1
let g:nord_uniform_diff_background = 1

let g:tex_flavor = 'latex'

"markdown
let g:markdown_fenced_languages = ['bash', 'c', 'asm', 'lua', 'python', 'html', 'css']

"general settings
colo nord
let mapleader=" "
set number
set relativenumber
set autoindent
set tabstop=8
set softtabstop=4
set shiftwidth=4
set noexpandtab
set cursorline
set wildmenu "visual command completion menu
set path+=** "set vim to recursively look through subdirectories when dealing with filepaths
set clipboard=unnamedplus
set incsearch 
set ignorecase
set smartcase
set spell
syntax enable
autocmd BufEnter *.CPP :setlocal filetype=cpp "Fix .CPP not auto highlighting syntax
set cm=blowfish2

"General remaps
nmap <leader>n :NERDTreeToggle<CR> 
tmap <leader><ESC> <C-\><C-n>
