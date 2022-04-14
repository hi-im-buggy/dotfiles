(module magic.plugin.gitsigns
  {autoload {}})

(let [(ok? gitsigns) (pcall #(require :gitsigns))]
  (when ok?
    (gitsigns.setup {})))
