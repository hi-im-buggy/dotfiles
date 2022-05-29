(module magic.plugin.treesitter)

(let [(ok? treesitter-configs) (pcall #(require :nvim-treesitter.configs))]
  (when ok?
    (treesitter-configs.setup
      {:ensure_installed [:c :comment :markdown :python]
       :highlight {:enable true}})))
