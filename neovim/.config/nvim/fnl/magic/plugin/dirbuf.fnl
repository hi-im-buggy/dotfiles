(module magic.plugin.dirbuf
  {autoload {nvim aniseed.nvim}})

(let [(ok? dirbuf) (pcall #(require :dirbuf))]
  (when ok?
    (dirbuf.setup {:hash_first false
                   :sort_order :directories_first})))
