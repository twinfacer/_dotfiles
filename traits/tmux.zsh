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
