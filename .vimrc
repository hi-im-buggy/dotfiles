call plug#begin('~/.vim/bundle')
Plug 'junegunn/vim-plug' "Plugin manager
Plug 'arcticicestudio/nord-vim' "Nord colorscheme
Plug 'vim-airline/vim-airline' "lean statusbar
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-sensible' "tpope's defaults
Plug 'tpope/vim-commentary' "commenti toggle plugin
Plug 'christoomey/vim-tmux-navigator' "allows seamless navigation b/w vim and tmux panes
Plug 'chrisbra/Colorizer' "colorize hex codes
call plug#end()

set nu
set rnu
set autoindent
colo nord
set sw=4
set clipboard=unnamedplus
autocmd BufEnter *.CPP :setlocal filetype=cpp
