(module magic.plugin.gitsigns
  {autoload {nvim aniseed.nvim
             util magic.util}})

(let [(ok? gitsigns) (pcall #(require :gitsigns))]
  (when ok?
    (gitsigns.setup {})
    (util.lnnoremap :hp "Gitsigns preview_hunk")
    (util.lnnoremap :hr "Gitsigns reset_hunk")
    (util.nnoremap "]h" "Gitsigns next_hunk")
    (util.nnoremap "[h" "Gitsigns prev_hunk")))
