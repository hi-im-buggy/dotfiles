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
call plug#end()

nmap <C-n> :NERDTreeToggle<CR> 
"
"nord-vim customizations
let g:nord_bold = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_cursor_line_number_background = 1
let g:nord_uniform_diff_background = 1

"general settings
set nu
set rnu
set autoindent
colo nord
set sw=4
set clipboard=unnamedplus
autocmd BufEnter *.CPP :setlocal filetype=cpp
