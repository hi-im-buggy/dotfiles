(module magic.init
  {autoload {plugin magic.plugin
             nvim aniseed.nvim}})
;;; Based on [https://github.com/Olical/magic-kit]

;;; Generic configuration

(set nvim.o.termguicolors true)
(set nvim.o.mouse "a")
(set nvim.o.updatetime 500)
(set nvim.o.timeoutlen 500)
(set nvim.o.sessionoptions "blank,curdir,folds,help,tabpages,winsize")
(set nvim.o.listchars "tab:|->,trail:·")
(set nvim.o.inccommand :split)
(set nvim.o.clipboard :unnamedplus)

(nvim.ex.set :list)
(nvim.ex.set :nohlsearch)

;;; Mappings

(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader "\\")


;;; Plugins

;; Run script/sync.sh to update, install and clean your plugins.
;; Packer configuration format: https://github.com/wbthomason/packer.nvim
(plugin.use
  :Olical/aniseed {}
  :Olical/conjure {}
  :Olical/nvim-local-fennel {}
  :PeterRincker/vim-argumentative {}
  :lewis6991/gitsigns.nvim {:mod :gitsigns}
  :beauwilliams/statusline.lua {:mod :statusline}
  :clojure-vim/clojure.vim {}
  :clojure-vim/vim-jack-in {}
  :easymotion/vim-easymotion {}
  :folke/which-key.nvim {:mod :which-key}
  :guns/vim-sexp {:mod :sexp}
  :hrsh7th/nvim-compe {:mod :compe}
  :jiangmiao/auto-pairs {:mod :auto-pairs}
  :lewis6991/impatient.nvim {}
  :psliwka/vim-smoothie {}
  :marko-cerovac/material.nvim {:mod :material}
  :mbbill/undotree {:mod :undotree}
  :neovim/nvim-lspconfig {:mod :lspconfig}
  :nvim-telescope/telescope.nvim {:mod :telescope
                                  :requires [[:nvim-lua/popup.nvim]
                                             [:nvim-lua/plenary.nvim]]}
  :radenling/vim-dispatch-neovim {}
  :tami5/compe-conjure {}
  :tpope/vim-abolish {}
  :tpope/vim-commentary {}
  :tpope/vim-dispatch {}
  :tpope/vim-eunuch {}
  :tpope/vim-fugitive {:mod :fugitive}
  :tpope/vim-repeat {}
  :tpope/vim-sexp-mappings-for-regular-people {}
  :tpope/vim-sleuth {}
  :tpope/vim-surround {}
  :tpope/vim-unimpaired {}
  :tpope/vim-vinegar {}
  :wbthomason/packer.nvim {}
  )
