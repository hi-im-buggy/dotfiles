(module magic.plugin.indent-blankline
  {autoload {nvim aniseed.nvim}})

(let [(ok? indent-blankline) (pcall #(require :indent_blankline))]
  (when ok?
    (indent-blankline.setup {})))
