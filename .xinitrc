[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

exec awesome

setxkbmap -option ctrl:nocaps
xcape -e 'Control_L=Escape'

xinput set-prop "ETPS/2 Elantech Touchpad" 300 1
