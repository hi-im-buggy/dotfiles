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

(let [options [:list
               :nohlsearch
               :nonumber
               :ignorecase
               :smartcase
               :title
               :noswapfile
               :autoread]]
  ( each [ _ opt (ipairs options)]
    (nvim.ex.set opt)))

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
  :lewis6991/gitsigns.nvim {:mod :gitsigns
                            :run ":UpdateRemotePlugins"}
  :nvim-lualine/lualine.nvim {:mod :lualine
                              :requires [[:kyazdani42/nvim-web-devicons]]}
  :nvim-treesitter/nvim-treesitter {:mod :treesitter
                                    :run ":TSUpdate"}
  :lukas-reineke/indent-blankline.nvim {:mod :indent-blankline}
  :nvim-orgmode/orgmode {:mod :orgmode}
  :lukas-reineke/headlines.nvim {:mod :headlines}
  :folke/which-key.nvim {:mod :which-key}
  :guns/vim-sexp {:mod :sexp}
  :hrsh7th/nvim-compe {:mod :compe}
  :windwp/nvim-autopairs {:mod :autopairs}
  :lewis6991/impatient.nvim {}
  :psliwka/vim-smoothie {}
  :marko-cerovac/material.nvim {:mod :material}
  :NLKNguyen/papercolor-theme {}
  :mbbill/undotree {:mod :undotree}
  :neovim/nvim-lspconfig {:mod :lspconfig}
  :glepnir/lspsaga.nvim {:mod :lspsaga
                         :branch :main}
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
  :wbthomason/packer.nvim {}
  )
