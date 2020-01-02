call plug#begin('~/.vim/bundle')
Plug 'junegunn/vim-plug'
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
call plug#end()

set nu
set rnu
set autoindent
colo nord
set ts=4
set sw=4
set clipboard=unnamedplus
autocmd BufEnter *.CPP :setlocal filetype=cpp
