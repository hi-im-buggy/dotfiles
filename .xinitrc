[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

xinput set-prop "ETPS/2 Elantech Touchpad" 300 1
exec awesome
