export TMUX_DEFAULT_SESSION="system"

# configuration
alias tconf="ed ~/.tmux.conf"
alias tref="tmux source-file ~/.tmux.conf"

# client
alias td="tmux detach-client"

# sessions manipulation (ts*)
# TODO: wrap as function to `remind` about missing arguments or provide defaults
alias tsl="tmux list-sessions"
alias tsc="tmux new-session -s"
alias tsa="tmux attach-session -t"
alias tsk="tmux kill-session -t"

# jump to desired or `default` tmux session
restore() {
  target = ${1:-$TMUX_DEFAULT_SESSION}
  if [[ -z "$TMUX" ]];then
    tmux has-session -t $target || tmux new-session -s $target
    tmux attach-session -t $target
  fi
}
