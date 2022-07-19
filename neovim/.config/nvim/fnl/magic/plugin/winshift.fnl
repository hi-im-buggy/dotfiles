(module magic.plugin.winshift
  {autoload {util magic.util}})

(let [(ok? winshift) (pcall #(require :winshift))]
  (when ok?
    (winshift.setup {:higlight_moving_win true
                     :focused_hl_group "Visual"
                     :moving_win_options {}
                     :keymaps {:disable_defaults false
                               :win_move_mode {:h :left
                                               :j :down
                                               :k :up
                                               :l :right
                                               :H :far_left
                                               :J :far_down
                                               :K :far_up
                                               :L :far_right
                                               :<left> :left
                                               :<down> :down
                                               :<up> :up
                                               :<right> :right
                                               :<S-left> :far_left
                                               :<S-down> :far_down
                                               :<S-up> :far_up
                                               :<S-right> :far_right
                                               :x :swap}}
                     :window_picker (lambda []
                                      (let [pick_window (. (require :winshift.lib) :pick_window)]
                                        (pick_window {:picker_chars "FJDKSLA;GH"
                                                      :filter_rules {:cur_win true
                                                                     :floats true
                                                                     :filetype {}
                                                                     :buftype {}
                                                                     :bufname {}}
                                                      :filter_func nil})))})
    ;Mappings 
    (util.lnnoremap :ww "WinShift")
    (util.lnnoremap :wh "WinShift left")
    (util.lnnoremap :wl "WinShift right")
    (util.lnnoremap :wk "WinShift up")
    (util.lnnoremap :wj "WinShift down")
    (util.lnnoremap :wH "WinShift far_left")
    (util.lnnoremap :wL "WinShift far_right")
    (util.lnnoremap :wK "WinShift far_up")
    (util.lnnoremap :wJ "WinShift far_down")
    (util.lnnoremap :wx "WinShift swap")))
