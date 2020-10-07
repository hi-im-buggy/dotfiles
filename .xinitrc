[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

xinput set-prop "ETPS/2 Elantech Touchpad" 300 1
xinput set-prop "ELAN1300:00 04F3:3087 Touchpad" 330 1
xinput set-prop "ELAN1300:00 04F3:3087 Touchpad" 343 1
xinput set-prop "ELAN1300:00 04F3:3087 Touchpad" 312 1
exec awesome
