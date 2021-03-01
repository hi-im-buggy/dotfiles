" {{{ Plugins
call plug#begin('~/.config/nvim/bundle')
"Plugin manager
	Plug 'junegunn/vim-plug'
"tpope magic plugins
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-vinegar'
	Plug 'tpope/vim-unimpaired'
	Plug 'tpope/vim-eunuch'
"colorschemes
	Plug 'arcticicestudio/nord-vim'
	Plug 'joshdick/onedark.vim'
	Plug 'lifepillar/vim-gruvbox8'
"lean statusbar
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
"colorize hex codes
	Plug 'chrisbra/Colorizer'
"dev-icons for vim
	Plug 'ryanoasis/vim-devicons'
"Asynchronous linting engine
	Plug 'dense-analysis/ale'
"Distraction-free writing in vim
	Plug 'junegunn/goyo.vim'
	Plug 'junegunn/limelight.vim'
"racket plugin
	Plug 'wlangstroth/vim-racket'
"Pretty lambdas!
	Plug 'calebsmith/vim-lambdify'
call plug#end()
" }}}

"{{{ General settings
set nocp
set title background=dark
let mapleader=" "
set nonumber
set autoindent tabstop=4 softtabstop=4 shiftwidth=4
set cursorline
set wildmenu "visual command completion menu
set path+=src/**,config/
set clipboard=unnamedplus
set incsearch nohlsearch
set ignorecase smartcase
set spelllang=en_gb
set list listchars=tab:\ \ ,trail:⋅
set signcolumn=number
syntax enable
filetype plugin on
set omnifunc=ale#completion#OmniFunc completeopt=menu,menuone,noselect,noinsert

"General remaps
inoremap <C-l> <C-o>:w<CR>
nnoremap Y y$
tmap <leader><leader> <C-\><C-n><C-w><C-w>
tmap jj <C-\><C-n><Esc>
tmap <M-Space> <C-\><C-n>
cmap :W :w

"Leader maps
nmap <leader>l :set list!<CR>
nmap <leader>g :Gstatus<CR>
nmap <leader>z z=1<CR><CR>
nmap <leader>y :%!xclip -sel 'clipboard'<CR>u
nmap <leader>f :FZF<CR>
nmap <leader>h :noh<CR>
nmap <leader>c :!ctags -R<CR><CR>
nmap <leader>ws :%s/\s$//g<CR>

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

function! FontBellsAndWhistles() abort
	hi Comment gui=italic
	hi link Whitespace Comment
endfunction

augroup MakeItFancy
	autocmd!
	autocmd ColorScheme * call BackgroundTransparency()
	autocmd ColorScheme * call FontBellsAndWhistles()
augroup END

colo onedark
let g:airline_theme='onedark'
let g:onedark_terminal_italics=1

set conceallevel=2
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

"netrw/vinegar settings
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

"dev-icons for vim
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_airline_tabline = 0
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['rkt'] = 'λ'

"ALE settings
let g:ale_enabled = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_virtualtext_cursor = 1
let g:ale_completion_enabled = 1
let g:ale_linters = {
			\ 'c': ['clang'],
			\ 'cpp': ['clang++'] }
let g:ale_fixers = {
			\ 'c': ['remove_trailing_lines', 'trim_whitespace'],
			\ 'cpp': ['remove_trailing_lines', 'trim_whitespace'],
			\ 'markdown': ['trim_whitespace'] }

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
	set conceallevel=2
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
