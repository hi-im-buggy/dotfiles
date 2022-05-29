(module magic.plugin.orgmode)

(let [(ok-org? orgmode) (pcall #(require :orgmode))
      (ok-ts? ts-configs) (pcall #(require :nvim-treesitter.configs))]
  (when (and ok-org? ok-ts?)
    (orgmode.setup_ts_grammar)
    (ts-configs.setup
      {:highlight {:enable true
                   :disable [:org]
                   :additional_vim_regex_highlighting [:org]}
       :ensure_installed [:org]})
    (orgmode.setup
      {:org_agenda_files ["~/org/*"]
       :org_default_notes_file "~/org/refile.org"})))
