" {{{ Plugins
call plug#begin('~/.config/nvim/bundle')
"Plugin manager
	Plug 'junegunn/vim-plug'
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
"more tpope magic
	Plug 'tpope/vim-unimpaired'
"yet another tpope plugin
	Plug 'tpope/vim-eunuch'
"colorize hex codes
	Plug 'chrisbra/Colorizer'
"Latex plugin for vim
	Plug 'lervag/vimtex'
"Visual file tree plugin
	Plug 'scrooloose/nerdTree'
"dev-icons for vim
	Plug 'ryanoasis/vim-devicons'
"Nord colorscheme
	Plug 'arcticicestudio/nord-vim'
"onedark colorscheme
	Plug 'joshdick/onedark.vim'
"gruvbox colorscheme
	Plug 'lifepillar/vim-gruvbox8'
"Missing motion for vim
	Plug 'justinmk/vim-sneak'
"<C-v> <C-a> to increment a visual block
	Plug 'triglav/vim-visual-increment'
"Asynchronous linting engine
	Plug 'dense-analysis/ale'
"Distraction-free writing in vim
	Plug 'junegunn/goyo.vim'
	Plug 'junegunn/limelight.vim'
"rainbows for lisp madness!
	Plug 'frazrepo/vim-rainbow'
"racket plugin
	Plug 'wlangstroth/vim-racket'
call plug#end()
" }}}

"{{{ General settings
set nocp
set title background=dark
let mapleader=" "
set number relativenumber
set autoindent tabstop=4 softtabstop=4 shiftwidth=4
set cursorline
set wildmenu "visual command completion menu
set path+=src/**,config/
set clipboard=unnamedplus
set incsearch nohlsearch
set ignorecase smartcase
set spelllang=en_gb
set listchars=eol:$,tab:\|\ >,trail:~,space:+
syntax enable
filetype plugin on
set omnifunc=syntaxcomplete#Complete completeopt=menu,menuone,noselect,noinsert

"General remaps
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
tmap <leader><leader> <C-\><C-n><C-w><C-w>
tmap jj <C-\><C-n><Esc>
tmap <M-Space> <C-\><C-n>
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>l :set list!<CR>
nmap <leader>z z=1<CR><CR>
nmap <leader>y :%!xclip -sel 'clipboard'<CR>u
nmap <leader>f :FZF<CR>
nmap <leader>h  :noh<CR>

"General appearance
if exists('+termguicolors')
	let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

function! BackgroundTransparency() abort
	hi Normal guibg=NONE ctermbg=NONE
	hi SignColumn guibg=NONE
endfunction
augroup MyColors
	autocmd!
	autocmd ColorScheme * call BackgroundTransparency()
augroup END
colo onedark
let g:airline_theme='onedark'
" }}}

"{{{ Plugin settings
"Goyo and limelight hand in hand
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

let g:limelight_conceal_ctermfg = 240
let g:limelight_conceal_guifg = '#555555'
let g:limelight_default_coefficient = 0.5
let g:limelight_paragraph_span = 0

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
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#checks = [ 'trailing', 'conflicts' ]

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_symbols.branch = ''
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.readonly = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

"dev-icons for vim
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_airline_tabline = 0
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['rkt'] = 'λ'

"ALE settings
let g:ale_enabled = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_virtualtext_cursor = 1
let g:ale_set_ballons = 1
let g:ale_completion_enabled = 1
let g:ale_linters = {'c': ['clang'], 'cpp': ['clang++']}

"Make nerdtree be the preferred ':edit' for directories
let g:NERDTreeHijackNetrw = 1
"}}}

"{{{ Markdown
let g:markdown_fenced_languages =
	\ ['make', 'bash', 'c', 'asm', 'lua', 'python', 'html', 'css']
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
"}}}

""{{{ Misc
" load custom 'plugins'
source ~/.config/nvim/redir.vim

" UTF-8 support
if exists('+multi_byte')
	scriptencoding utf-8
	set encoding=utf-8
endif

"Use folding where possible
if has ('folding')
	set foldenable
	set foldmethod=marker
	set foldmarker={{{,}}}
	set foldcolumn=0
endif

"upon entering the terminal
autocmd TermOpen * setlocal nonumber
autocmd TermOpen * setlocal norelativenumber
autocmd TermOpen * setlocal nospell
autocmd TermOpen * startinsert
"}}}
