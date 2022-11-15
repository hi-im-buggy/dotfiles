(module magic.plugin.catppuccin
  {autoload {nvim aniseed.nvim}})

(let [(ok? catppuccin) (pcall #(require :catppuccin))]
  (when ok?
    (set nvim.g.catppuccin_flavour :mocha)
    (catppuccin.setup {})))
