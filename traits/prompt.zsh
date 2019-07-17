setopt PROMPT_SUBST

# promt parts
mode_prompt() {
  # TODO: Add last exit status
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    local connection="f817";
  else
    local connection="fcb5";
  fi
  echo " $(icon $connection) "
}

path_prompt() {
  local current_path=$(pwd | sed "s:$HOME:~:")
  echo " $current_path "
}

git_prompt() {
  local current_branch=$(git_current_branch)
  local branch_type_icon=$(icon "e725")
  local bug_icon=$(icon "f188")
  if [[ $current_branch =~ 'feature/' ]]; then
    current_branch=${current_branch//feature\//}
  elif [[ $current_branch =~ 'bugfix/' ]]; then
    current_branch=${current_branch//bugfix\//}
    branch_type_icon=$bug_icon
  fi
  if [[ -n $(git status -s) ]]; then
    local status_color=yellow
  else
    local status_color=black
  fi
  echo " %F{$status_color}$branch_type_icon%f %F{black}$current_branch%f "
}

rvm_prompt() {
  echo "No RVM" && return
  local icon=$(icon "\ue21e")
  local ruby_version=$(rvm-prompt | sed -e s/ruby-// -e s/-latest//)
  echo " $icon $ruby_version "
}

build_segment() {
  local segment=$(colorize "$1" $2 $3)
  echo "$segment"
}

build_left_prompt() {
  local separator="e0b0"
  local _prompt=""
  _prompt+=$(build_segment "$(mode_prompt)" yellow black )
  _prompt+=$(build_segment $(icon "$separator") blue yellow)
  _prompt+=$(build_segment "$(path_prompt)" blue)
  _prompt+=$(build_segment $(icon "$separator") transparent blue)
  echo "${_prompt} "
}

build_right_prompt() {
  local _prompt=""
  if [[ -d "$(pwd)/.git" ]]; then
    _prompt+=$(build_segment $(icon "e0b2") transparent green)
    _prompt+=$(build_segment "$(git_prompt)" green black)
    _prompt+=$(build_segment $(icon "e0b2") green red)
  else
    _prompt+=$(build_segment $(icon "e0b2") transparent red)
  fi
  _prompt+=$(build_segment "$(rvm_prompt)" red 008)
  echo -n "${_prompt}"
}

PROMPT='$(build_left_prompt)'
RPROMPT='$(build_right_prompt)'
