callable tmux || return

export TMUX_DEFAULT_SESSION="system"

# jump to desired or `default` tmux session
_restore_tmux_session() {
  local target=${1:-$TMUX_DEFAULT_SESSION}
  if [[ -z "$TMUX" ]];then
    tmux has-session -t $target || tmux new-session -s $target
    tmux attach-session -t $target
  fi
}

# Edit tmux configuration using primary editor.
alias tconf="ed ~/.tmux.conf"

# Reload tmux configuration.
alias tref="tmux source-file ~/.tmux.conf"

# Restore tmux session.
alias tsr="_restore_tmux_session"

[ "$TMUX_AUTORESTORE" = true ] && _restore_tmux_session