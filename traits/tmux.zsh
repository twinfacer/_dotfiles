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

# sessions manipulation (ts*)
alias tsr="restore"

[ "$TMUX_AUTORESTORE" = true ] && restore