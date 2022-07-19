(module magic.plugin.lspconfig)

;; 'from' is a string, 'to' is a function
(defn- nmap [from to]
  (vim.keymap.set :n from to))

(let [(ok? lsp) (pcall #(require :lspconfig))]
  (when ok?
    (lsp.clojure_lsp.setup {})
    (lsp.clangd.setup {})
    (lsp.pyright.setup {})
    (lsp.tsserver.setup {})
    (lsp.sumneko_lua.setup
      {:cmd ["lua-language-server"]
       :settings {:Lua {:telemetry {:enable false}}}})

    ;; https://www.chrisatmachine.com/Neovim/27-native-lsp/
    (nmap :gd vim.lsp.buf.definition)
    (nmap :gD vim.lsp.buf.declaration)
    (nmap :gr vim.lsp.buf.references)
    (nmap :gi vim.lsp.buf.implementation)
    (nmap :<c-k> vim.lsp.buf.signature_help)
    (nmap :<c-p> vim.diagnostic.goto_prev)
    (nmap :<c-n> vim.diagnostic.goto_next)
    (nmap :<leader>lf vim.lsp.buf.formatting)))
