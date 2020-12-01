call plug#begin('~/.vim/bundle')
"Plugin manager
	Plug 'junegunn/vim-plug'
"Nord colorscheme
	Plug 'arcticicestudio/nord-vim'
"lean statusbar
	Plug 'vim-airline/vim-airline'
"themes for the same
	Plug 'vim-airline/vim-airline-themes'
"tpope's defaults
	Plug 'tpope/vim-sensible'
"commenting toggle plugin
	Plug 'tpope/vim-commentary'
"another helpful tpope plugin
	Plug 'tpope/vim-surround'
"git plugin by tpope again
	Plug 'tpope/vim-fugitive'
"colorize hex codes
	Plug 'chrisbra/Colorizer'
"Latex plugin for vim
	Plug 'lervag/vimtex'
"Visual file tree plugin
	Plug 'scrooloose/nerdTree'
" <C-v> <C-a> to increment a visual block
	Plug 'triglav/vim-visual-increment'
"Loads of vim colorschemes
	Plug 'flazz/vim-colorschemes'
"Asynchronous linting engine
	Plug 'dense-analysis/ale'
"Distraction-free writing in vim
	Plug 'junegunn/goyo.vim'
"rainbows for lisp madness!
	Plug 'frazrepo/vim-rainbow'
"Deoplete - Dark Powered Neo-Completion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Deoplete for C/C++
	Plug 'zchee/deoplete-clang'
endif
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
colo gruvbox
let mapleader=" "
set number
set relativenumber
set autoindent
set tabstop=4
set shiftwidth=4
set cursorline
set wildmenu "visual command completion menu
set path+=/home/buggy
set path+=** "set vim to recursively look through subdirectories when dealing with file paths
set clipboard=unnamedplus
set incsearch
set ignorecase
set smartcase
set spell
set spelllang=en_gb
set title
set nolist
set listchars=eol:$,tab:\|\ >,trail:~,space:+
syntax enable
set nocp
filetype plugin on
set omnifunc=syntaxcomplete#Complete

"General remaps
inoremap <M-Space> <ESC>
inoremap jj <ESC>
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
nmap <leader>n :NERDTreeToggle<CR>
tmap <leader><ESC> <C-\><C-n>
tmap <M-Space> <C-\><C-n>
nmap <leader>l :set list!<CR>
nmap <leader>z z=1<CR><CR>
nmap <leader>y :%!xclip -sel 'clipboard'<CR>u
noremap <expr> j (v:count? 'j' : 'gj') 
noremap <expr> k (v:count? 'k' : 'gk') 
nmap <leader>f :FZF<CR>

"general appearance
hi Normal guibg=NONE ctermbg=NONE

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
let g:airline_theme='base16_gruvbox_dark_hard'
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

"To get better syntax highlighting for embedded LaTeX math in markdown files
"taken from https://stsievert.com/blog/2016/01/06/vim-jekyll-mathjax/
function! MathAndLiquid()
    "" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    " inline math. Look for "$[not $][anything]$"
    syn match math_block '\$[^$].\{-}\$'

    " Liquid single line. Look for "{%[anything]%}"
    syn match liquid '{%.*%}'
    " Liquid multiline. Look for "{%[anything]%}[anything]{%[anything]%}"
    syn region highlight_block start='{% highlight .*%}' end='{%.*%}'

    "" Actually highlight those regions.
    hi link math String
    hi link liquid Statement
    hi link highlight_block Function
    hi link math_block Macro
endfunction

" Call everytime we open a Markdown file
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()

"deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = "/usr/lib/libclang.so"
let g:deoplete#sources#clang#clang_header = "/usr/lib/clang"

" doesn't seem to work on nvim for some reason that I'm too lazy to figure out
if has("vim")
	set cm=blowfish2
endif

"rainbows for lisp madness
au FileType lisp,racket call rainbow#load()

" neovim specifics
if has("nvim")
	let g:neovide_transparency=0.8
endif
