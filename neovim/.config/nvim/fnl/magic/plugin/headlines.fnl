(module magic.plugin.headlines)

(let [(ok? headlines) (pcall #(require :headlines))]
  (when ok?
    (headlines.setup {:org {:fat_headlines false}})))
