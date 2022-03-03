alias a='tmux attach -t'
alias n='tmux new -s'
alias f='fzf'
alias g='git'
alias l='ls'
alias ll='ls -l'

alias tbin='nc termbin.com 9999'
alias tbincopy='nc termbin.com 9999 | xclip -selection c'
alias reddit='ttrv --enable-media'
alias assaultcube='~/AssaultCube_v1.2.0.2/assaultcube.sh'
alias pomo='muccadoro | tee -ai ~/pomodoros.txt'
alias yt='straw-viewer'
alias todo='nvim ~/checklists/todo.md'
alias stdcpy="xclip -sel 'clipboard'"
alias vimp='nvim -u NONE' #"plain vim"
alias py='python3'
alias screencast='ffmpeg -f x11grab -s 1920x1080 -i :0.0 -r 25 -vcodec libx264'
alias iiitvpn='sudo openvpn --config /home/buggy/scripts/linux.ovpn'
alias nsresolv='sudoedit  /etc/resolv.conf{,.bak}'
alias icat='kitty +kitten icat'
alias ssh='kitty +kitten ssh'
