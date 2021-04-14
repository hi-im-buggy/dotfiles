"{{{ Plugins
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
	Plug 'tpope/vim-repeat'
"colorschemes
	Plug 'arcticicestudio/nord-vim'
	Plug 'joshdick/onedark.vim'
	Plug 'lifepillar/vim-gruvbox8'
	Plug 'YorickPeterse/vim-paper'
"colorize hex codes
	Plug 'chrisbra/Colorizer'
"Asynchronous linting engine
	Plug 'dense-analysis/ale'
"Devicons for vim
	Plug 'ryanoasis/vim-devicons'
"racket plugin
	Plug 'wlangstroth/vim-racket'
"Pretty lambdas!
	Plug 'calebsmith/vim-lambdify'
"Highlight yanks
	Plug 'machakann/vim-highlightedyank'
"Smooth scrolling
	Plug 'psliwka/vim-smoothie'
"Undo tree
	Plug 'simnalamburt/vim-mundo'
"Neovim tree-sitter
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Latex plugin
	Plug 'lervag/vimtex'
"Snippets
	Plug 'sirver/ultisnips'
"buffer selector
	Plug 'jeetsukumaran/vim-buffergator'
call plug#end()
"}}}

"{{{ General settings
set nocp
set title background=dark
let mapleader=" "
set number
set autoindent tabstop=4 softtabstop=4 shiftwidth=4
set cursorline
set wildmenu "visual command completion menu
set clipboard=unnamedplus
set incsearch nohlsearch inccommand=nosplit
set ignorecase smartcase
set spelllang=en_gb
set list listchars=tab:›\ ,trail:⋅
set signcolumn=number
set hidden
syntax enable
filetype plugin on
set omnifunc=ale#completion#OmniFunc completeopt=menu,menuone,noselect,noinsert
set grepprg=rg\ --vimgrep\ --no-heading
set mouse+=a
set undofile undodir=~/.config/nvim/undo

"General remaps
inoremap <C-l> <C-o>:w<CR>
nnoremap Y y$
tmap jj <C-\><C-n><Esc>
tmap <M-Space> <C-\><C-n>
cmap :W :w

"Leader maps
tmap <leader><leader> <C-\><C-n><C-w><C-w>
nmap <leader>l :set list!<CR>
nmap <leader>g :Gstatus<CR>
nmap <leader>z z=1<CR><CR>
nmap <leader>y :%!xclip -sel 'clipboard'<CR>u
nmap <leader>f :FZF<CR>
nmap <leader>h :noh<CR>
nmap <leader>c :!ctags -R<CR><CR>
nmap <leader>ws :%s/\s$//g<CR>
nmap <leader>s :w<CR>
nmap <leader>m :!make<CR>
nmap <leader>d :!sr duckduckgo
nmap <leader>u :MundoToggle<CR>
nmap <leader>b :BuffergatorOpen<CR>
nmap <leader>B :BuffergatorClose<CR>
nmap <leader>t :BuffergatorTabsOpen<CR>
nmap <leader>T :BuffergatorTabsClose<CR>

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

augroup UnlistedNetrwBufs
	autocmd filetype netrw setlocal nobuflisted
augroup END

colo onedark
let g:onedark_terminal_italics=1
"}}}

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

"netrw/vinegar settings
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

"highlight yank
let g:highlightedyank_highlight_duration = 500

"ALE settings
let g:ale_enabled = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_virtualtext_cursor = 1
let g:ale_completion_enabled = 1
let g:ale_root= {}
let g:ale_linters = {
			\ 'c': ['clang'],
			\ 'cpp': ['clang++'],
			\ 'python': ['flake8']}
let g:ale_fixers = {
			\ 'c': ['remove_trailing_lines', 'trim_whitespace'],
			\ 'cpp': ['remove_trailing_lines', 'trim_whitespace'],
			\ 'markdown': ['trim_whitespace'] }


"UltiSnips settings
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"Devicons settings
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['rkt'] = 'λ'

"Buffergator
let g:buffergator_suppress_keymaps = 1

"Lua plugins
lua << EOF
-- Treesitter config settings
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
	"c", "c"
  }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,             -- false will disable the whole extension
  },
}
EOF
"}}}

"{{{ Markdown
let g:markdown_fenced_languages =
	\ ['make', 'sh', 'c', 'asm', 'lua', 'python', 'html', 'css', 'cpp']

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

	" Actually highlight those regions.
	hi link math String
	hi link liquid Statement
	hi link highlight_block Function
	hi link math_block Macro
	set conceallevel=2
endfunction

"Call everytime we open a Markdown file
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()
"}}}

"{{{ Latex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'
set conceallevel=1
"}}}

"{{{ Misc
"load custom 'plugins'
source ~/.config/nvim/redir.vim

"UTF-8 support
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
