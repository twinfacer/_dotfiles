callable tmux || return

export TMUX_DEFAULT_SESSION="system"

# jump to desired or `default` tmux session
restore() {
  local target=${1:-$TMUX_DEFAULT_SESSION}
  if [[ -z "$TMUX" ]];then
    tmux has-session -t $target || tmux new-session -s $target
    tmux attach-session -t $target
  fi
}

# configuration management
alias tconf="ed ~/.tmux.conf"
alias tref="tmux source-file ~/.tmux.conf"

# client
alias tdc="tmux detach-client"
alias tlc="tmux list-clients"

# sessions manipulation (ts*)
alias tsl="tmux list-sessions"
alias tsc="tmux new-session -s"
alias tsa="tmux attach-session -t"
alias tsk="tmux kill-session -t"
alias tsr="restore"

[ "$TMUX_AUTORESTORE" = true ] && restore