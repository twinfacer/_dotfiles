callable ssh || return

function _conn_type() {
  if [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" ]]; then
    echo "remote"
  else
    echo "local"
  fi
}

alias ssg="ssh-keygen -t rsa -b 4096"
alias ssc="cat ~/.ssh/id_rsa.pub | clipcopy"
