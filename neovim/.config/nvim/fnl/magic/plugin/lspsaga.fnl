(module magic.plugin.lspsaga
  {autoload {util magic.util}})

(defn- nmap [from to]
  (vim.keymap.set :n from to))

(let [(ok? saga) (pcall #(require :lspsaga))]
  (when ok?
    (saga.init_lsp_saga {:border_style :rounded
                         :code_action_icon :λ})
    ;; bindings
    (let [finder (. (require :lspsaga.finder) :lsp_finder)
          hover_doc (. (require :lspsaga.hover) :render_hover_doc)
          diagnostic (. (require :lspsaga.diagnostic) :show_line_diagnostics)
          code_action (. (require :lspsaga.codeaction) :code_action)
          definition (. (require :lspsaga.definition) :preview_definition)
          scroll (. (require :lspsaga.action) :smart_scroll_with_saga) 
          rename (. (require :lspsaga.rename) :lsp_rename)]
      (nmap :gh finder)
      (nmap :K hover_doc)
      (nmap :<leader>e diagnostic)
      (nmap :<leader>d definition)
      (nmap :<C-f> (lambda [] (scroll 1)))
      (nmap :<C-b> (lambda [] (scroll -1)))
      (nmap :<leader>ca code_action)
      (nmap :<leader>lr rename))))
