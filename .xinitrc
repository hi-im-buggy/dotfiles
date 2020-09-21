[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

xinput set-prop "ETPS/2 Elantech Touchpad" 300 1
xinput set-prop 13 330 1
xinput set-prop 13 343 1
xinput set-prop 13 312 1
exec awesome
