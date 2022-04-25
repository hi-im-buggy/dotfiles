(module magic.plugin.autopairs
  {autoload {nvim aniseed.nvim
             util magic.util}})

(let [(ok? autopairs) (pcall #(require :nvim-autopairs))]
  (when ok?
    (autopairs.setup
       {:ignored_next_char "[%w%.%:]"})))
