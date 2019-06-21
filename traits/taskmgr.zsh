[[ -n $TASK_TRACKER_PATH ]] || return

_task_number() {
  git_current_branch | egrep -o '[0-9]+'
}

_task_link() {
  echo "$TASK_TRACKER_PATH$(_task_number)"
}

_task_open() {
  $BROWSER $(_task_link)
}

_tasks_list() {
  git branch -l | grep 'feature/' | sed 's/feature\///'
}

tasks_switch() {
  git checkout "feature/$1"
}

#compdef _tasks_switch tasks_switch

function _tasks_switch {
  local completions
  completions="$(git branch -l | grep 'feature/' | sed 's/feature\///')"
  reply=( "${(ps:\n:)completions}" )
}

compctl -f -K _tasks_switch tasks_switch

alias tk="_task_number"
alias tko="_task_open"
alias tkc=" _task_link | clipcopy"
alias tkl="_tasks_list"
alias tks="tasks_switch"
