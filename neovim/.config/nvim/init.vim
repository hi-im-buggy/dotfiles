"{{{ Plugins
call plug#begin('~/.config/nvim/bundle')
"Plugin manager
	Plug 'junegunn/vim-plug'
"tpope magic plugins
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-eunuch'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-repeat'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-unimpaired'
	Plug 'tpope/vim-vinegar'
"colorschemes
	Plug 'YorickPeterse/vim-paper'
	Plug 'arcticicestudio/nord-vim'
	Plug 'joshdick/onedark.vim'
	Plug 'romgrk/doom-one.vim'
"languge-specific
	Plug 'drmingdrmer/vim-syntax-markdown'
	Plug 'lervag/vimtex'
	Plug 'wlangstroth/vim-racket'
"colorize hex codes
	Plug 'chrisbra/Colorizer'
"Rainbow parens
	Plug 'kien/rainbow_parentheses.vim'
"Handle file:line style filenames
	Plug 'bogado/file-line'
"Highlight yanks
	Plug 'machakann/vim-highlightedyank'
"Smooth scrolling
	Plug 'psliwka/vim-smoothie'
"Undo tree
	Plug 'simnalamburt/vim-mundo'
"Neovim tree-sitter
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Note taking
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'https://github.com/alok/notational-fzf-vim'
"Snippets
	Plug 'sirver/ultisnips'
"tiny pretty statusline
	Plug 'rafi/vim-tinyline'
"neovim language server protocol
	Plug 'neovim/nvim-lspconfig'
	Plug 'kabouzeid/nvim-lspinstall'
"auto completion
	Plug 'hrsh7th/nvim-compe'
"competitive programming io
	Plug 'ex-surreal/vim-std-io'
"vimspector gadget
	Plug 'puremourning/vimspector'
"lispy goodness, fennel helpers
	Plug 'Olical/aniseed', {'tag': 'v3.20.0'}
"conversational software development for lisp
	Plug 'Olical/conjure', {'tag': 'v4.22.1'}
call plug#end()
"}}}

"{{{ General settings
set nocp
set title background=dark
let mapleader=" "
let maplocalleader=" "
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

"General remaps
nmap Y y$
nnoremap <C-n> +
nnoremap <C-p> -
nnoremap <C-j> :next<CR>
nnoremap <C-k> :previous<CR>
nnoremap <Tab> gt
nnoremap <S-Tab> gT
tnoremap jj <C-\><C-n><Esc>
tnoremap <M-Space> <C-\><C-n>

"Leader maps
tnoremap <leader><leader> <C-\><C-n><C-w><C-w>
nnoremap <leader>g :Git<CR>
nnoremap <leader>z z=1<CR><CR>
nnoremap <leader>m :!make<CR>
nnoremap <leader>u :MundoToggle<CR>
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>w <C-w>
nnoremap <leader>; <C-^>
nnoremap <leader>n :NV<CR>
nnoremap <leader>a :argadd %<CR>

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

let g:enable_fancy_visuals=0
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

"Lua plugins
lua << EOF
-- Treesitter config settings
require'nvim-treesitter.configs'.setup {
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
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- setup lspinstall
require'lspinstall'.setup()

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{ on_attach = on_attach }
end

-- nvim-compe setup for auto completion
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = false;
    ultisnips = true;
  };
}
EOF

" Non-lua mappings for nvim-compe
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" vim-std-io
let g:std_io_map_default = 0

"vimspector
let g:vimspector_enable_mappings = 'HUMAN'
"}}}

"{{{ Markdown
let g:markdown_fenced_languages =
	\ ['make', 'sh', 'c', 'asm', 'lua', 'python',
	\ 'html', 'css', 'cpp', 'gnuassembler=asm',
	\ 'lisp']
let g:vim_markdown_math = 1
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
