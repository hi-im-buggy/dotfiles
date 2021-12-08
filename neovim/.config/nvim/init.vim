"{{{ Plugins
call plug#begin('~/.config/nvim/bundle')
"plugin manager
	Plug 'junegunn/vim-plug'
"tpope magic plugins
	Plug 'tpope/vim-eunuch'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-repeat'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-unimpaired'
"colorschemes
	Plug 'YorickPeterse/vim-paper'
	Plug 'arcticicestudio/nord-vim'
	Plug 'joshdick/onedark.vim'
	Plug 'NTBBloodbath/doom-one.nvim'
	Plug 'wadackel/vim-dogrun'
"languge-specific
	Plug 'lervag/vimtex'
	Plug 'wlangstroth/vim-racket'
"make pandoc work better
	Plug 'vim-pandoc/vim-pandoc-syntax'
	Plug 'vim-pandoc/vim-pandoc'
"colorize hex codes
	Plug 'chrisbra/Colorizer'
"handle file:line style filenames
	Plug 'bogado/file-line'
"highlight yanks
	Plug 'machakann/vim-highlightedyank'
"smooth scrolling
	Plug 'psliwka/vim-smoothie'
"undo tree
	Plug 'simnalamburt/vim-mundo'
"neovim tree-sitter
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"fuzzy finding
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim',
"note taking
	Plug 'alok/notational-fzf-vim'
"snippets
	Plug 'sirver/ultisnips'
"neovim language server protocol
	Plug 'neovim/nvim-lspconfig'
	Plug 'kabouzeid/nvim-lspinstall'
"competitive programming io
	Plug 'ex-surreal/vim-std-io'
"lispy goodness, fennel helpers
	Plug 'Olical/aniseed'
"conversational software development for lisp
	Plug 'Olical/conjure'
"general lua dependency
	Plug 'nvim-lua/plenary.nvim'
"gitsigns
	Plug 'lewis6991/gitsigns.nvim'
"dirvish
	Plug 'justinmk/vim-dirvish'
"new commenting plugin, ala vim-commentary
	Plug 'numToStr/Comment.nvim'
"sudowrite plugin
	Plug 'lambdalisue/suda.vim'
call plug#end()
"}}}

"{{{ General settings
set nocp
set title background=dark
let mapleader=" "
let maplocalleader="\\"
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
set completeopt=menu,menuone,noselect,noinsert
set grepprg=rg\ --vimgrep\ --no-heading
set mouse+=a
set iskeyword+='-'
set path=.,./**
set signcolumn=yes
set showcmd

"Statusine
set statusline =%<%f\ 
set statusline +=%h%m%r
set statusline +=%{FugitiveStatusline()}
set statusline +=%=%-14.(%l,%c%V%)\ %P

"General remaps
nmap Y y$
nnoremap <C-n> +
nnoremap <C-p> -
nnoremap <Tab> gt
nnoremap <S-Tab> gT
inoremap <C-\> <Esc>Bi\<Esc>A
tnoremap jj <C-\><C-n><Esc>
tnoremap <M-Space> <C-\><C-n>

"Leader maps
nnoremap <leader>; <C-^>
nnoremap <leader>: :Commands<CR>
nnoremap <leader>/ :Lines<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :Git<CR>
nnoremap <leader>m :!make<CR>
nnoremap <leader>n :NV<CR>
nnoremap <leader>p :Pandoc pdf<CR>
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>u :MundoToggle<CR>
nnoremap <leader>w <C-w>
nnoremap <leader>z z=1<CR><CR>
tnoremap <leader><leader> <C-\><C-n><C-w><C-w>

"is this even a remap?
command! W write

"General appearance
if exists('+termguicolors')
	let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

function! BackgroundTransparency() abort
	hi Normal guibg=NONE
	hi SignColumn guibg=NONE
endfunction

function! FontBellsAndWhistles() abort
	hi Comment gui=italic
	hi link Whitespace Comment
endfunction

let g:enable_fancy_visuals = 0
if (g:enable_fancy_visuals)
	augroup MakeItFancy
		autocmd!
		autocmd ColorScheme * call BackgroundTransparency()
		autocmd ColorScheme * call FontBellsAndWhistles()
	augroup END
endif

augroup UnlistedNetrwBufs
	autocmd filetype netrw setlocal nobuflisted
augroup END

colo doom-one
let g:onedark_terminal_italics=1
"}}}

"{{{ Plugin settings
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

"UltiSnips settings
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

"nv-fzf
let g:nv_search_paths = ['~/Notes', './notes/']

"vim-dirvish
let g:dirvish_mode = ':silent keeppatterns g@\v/\.[^\/]+/?$@d _'

"Lua plugins
lua << EOF
-- Treesitter config settings
require('nvim-treesitter.configs').setup {
	ensure_installed = "maintained",
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true
	},
	indent = { enable = false },
	incremental_selection = { enable = true }
}

--- lspconfig
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'g<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>Gq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>Gf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- setup lspinstall
require('lspinstall').setup()

local servers = require'lspinstall'.installed_servers()
table.insert(servers, 'racket_langserver')

for _, server in pairs(servers) do
  require'lspconfig'[server].setup{ on_attach = on_attach }
end

-- git signs
require('gitsigns').setup()

-- Comment.nvim
require('Comment').setup()

local ft = require('Comment.ft')

ft.set('pandoc', {
	'<!-- %s -->',
	'<!-- %s -->'
	})

EOF
" end lua

" vim-std-io
let g:std_io_map_default = 0

"termdebug
let g:termdebug_wide = 1

"}}}

"{{{ Markdown
let g:markdown_fenced_languages =
	\ ['make', 'sh', 'c', 'asm', 'lua', 'python',
	\ 'html', 'css', 'cpp', 'gnuassembler=asm',
	\ 'lisp']
let g:vim_markdown_math = 1

"vim pandoc
let g:pandoc#filetypes#pandoc_markdown = 1
let g:pandoc#modules#disabled = ["folding"]
let g:pandoc#folding#fdc  = 0

let g:pandoc#command#autoexec_on_writes = 0
let g:pandoc#command#autoexec_command = "Pandoc pdf"
let g:pandoc#command#use_message_buffers = 0

let g:pandoc#command#custom_open = "MyPandocOpen"
function! MyPandocOpen(file)
	let file = shellescape(fnamemodify(a:file, ':p'))
	let file_extension = fnamemodify(a:file, ':e')
	if file_extension is? 'pdf'
		if !empty($PDFVIEWER)
			return expand('$PDFVIEWER') . ' ' . file
		elseif executable('zathura')
			return 'zathura ' . file
		elseif executable('mupdf')
			return 'mupdf ' . file
		endif
	elseif file_extension is? 'html'
		if !empty($BROWSER)
			return expand('$BROWSER') . ' ' . file
		elseif executable('firefox')
			return 'firefox ' . file
		elseif executable('chromium')
			return 'chromium ' . file
		endif
	elseif file_extension is? 'odt' && executable('okular')
		return 'okular ' . file
	elseif file_extension is? 'epub' && executable('okular')
		return 'okular ' . file
	else
		return 'xdg-open ' . file
	endif
endfunction
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
