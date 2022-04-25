;;; Based on [https://github.com/Olical/magic-kit]
(module magic.init
  {autoload {plugin magic.plugin
             nvim aniseed.nvim
             util magic.util}})

;;; Generic configuration

(set nvim.o.termguicolors true)
(set nvim.o.mouse "a")
(set nvim.o.updatetime 500)
(set nvim.o.timeoutlen 500)
(set nvim.o.sessionoptions "blank,curdir,folds,help,tabpages,winsize")
(set nvim.o.showbreak "↪ ")
(set nvim.o.listchars "tab:» ,trail:·")
(set nvim.o.inccommand :split)
(set nvim.o.clipboard :unnamedplus)
(set nvim.o.grepprg "rg --vimgrep --smart-case --hidden")
(set nvim.o.grepformat "%f:%l:%c:%m")

(nvim.ex.set :list)
(nvim.ex.set :nohlsearch)
(nvim.ex.set :number)
(nvim.ex.set :smartcase)

;;; Mappings

(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader "\\")
(util.tnoremap :<Esc> :<C-\><C-n>)

;;; Plugins
(plugin.use
  :Olical/aniseed {}
  :Olical/conjure {}
  :Olical/nvim-local-fennel {}
  :PeterRincker/vim-argumentative {}
  :lewis6991/gitsigns.nvim {:mod :gitsigns}
  :beauwilliams/statusline.lua {:mod :statusline}
  :folke/which-key.nvim {:mod :which-key}
  :guns/vim-sexp {:mod :sexp}
  :hrsh7th/nvim-compe {:mod :compe}
  :windwp/nvim-autopairs {:mod :autopairs}
  :lewis6991/impatient.nvim {}
  :psliwka/vim-smoothie {}
  :marko-cerovac/material.nvim {:mod :material}
  :mbbill/undotree {:mod :undotree}
  :neovim/nvim-lspconfig {:mod :lspconfig}
  :nvim-telescope/telescope.nvim {:mod :telescope
                                  :requires [[:nvim-lua/popup.nvim]
                                             [:nvim-lua/plenary.nvim]]}
  :nvim-telescope/telescope-fzf-native.nvim {:run :make}
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
  :elihunter173/dirbuf.nvim {:mod :dirbuf}
  :github/copilot.vim {}
  :wbthomason/packer.nvim {}
  )
