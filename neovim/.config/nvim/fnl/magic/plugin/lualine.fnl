(module magic.plugin.lualine)

(let [(ok? lualine) (pcall #(require :lualine))]
  (when ok?
    (lualine.setup {:options {:theme :onedark
                              :section_separators ""
                              :component_separators ""}})))
