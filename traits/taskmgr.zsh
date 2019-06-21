[[ -n $TASK_TRACKER_PATH ]] || return

_task_number() {
  git_current_branch | egrep -o '[0-9]+'
}

_task_link() {
  "$TASK_TRACKER_PATH$(_task_number)"
}

_task_open() {
  $BROWSER _task_link
}

alias tk="_task_number"
alias tko="_task_open"
alias tkc=" _task_link | clipcopy"
