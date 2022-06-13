;; AWESOME FENNEL
;; author: Pratyaksh Gautam
;; ------------------------------
;; AWESOME LIBRARIES
;; ------------------------------
(pcall #(require :luarocks.loader))
(local beautiful (require :beautiful))
(local naughty (require :naughty))
(local os (require :os))

;; ----------------------------------------------------------------------
;; ERROR HANDLING
;; ----------------------------------------------------------------------
;; Error handling on startup
(when awesome.startup_errors
  (naughty.notify {:preset naughty.config.presets.critical
                   :title "Oops, there were errors during startup!"
                   :text awesome.startup_errors}))

;; Handle runtime errors after startup
(let [in-error false]
  (awesome.connect_signal
    "debug::error"
    (fn [err]
      (when (not in-error)
        (let [in-error true]
          (naughty.notify {:preset naughty.config.presets.critical}))))))

;; ----------------------------------------------------------------------
;; LOCAL VARIABLES
;; ----------------------------------------------------------------------
;; Preferred programs, theming etc.
(local modkey "Mod4")
(local terminal (or (os.getenv :TERMINAL) "kitty"))
(local editor (or (os.getenv :EDITOR) (.. terminal "-e" "nvim")))
(local visual (or (os.getenv :VISUAL) (.. terminal "-e" "nvim")))
(local browser (or (os.getenv :BROWSER) "firefox"))

;; Layouts
(local selected-layouts {:awful.layout.suit.tile
                         ; :awful.layout.suit.tile.left
                         ; :awful.layout.suit.tile.bottom
                         :awful.layout.suit.tile.top
                         :awful.layout.suit.fair
                         ; :awful.layout.suit.fair.horizontal
                         :awful.layout.suit.spiral
                         ; :awful.layout.suit.spiral.dwindle
                         :awful.layout.suit.max
                         ; :awful.layout.suit.max.fullscreen
                         ; :awful.layout.suit.magnifier
                         :awful.layout.suit.corner.nw
                         ; :awful.layout.suit.corner.ne
                         ; :awful.layout.suit.corner.sw
                         ; :awful.layout.suit.corner.se
                         :awful.layout.suit.floating})
