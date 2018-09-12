#!/usr/bin/env zsh

setopt PROMPT_SUBST

iconize() {
  echo -e "\u$1"
}

colorize() {
  echo -n "%K{$2}%F{${3}}$1%f%k"
}

# promt parts
mode_prompt() {
  echo " $(iconize "fcb5") "
}

path_prompt() {
  local replacer="$(iconize "e5ff") $icon"
  local current_path=$(pwd | sed "s:$HOME/:$replacer:")
  echo " $current_path "
}

git_prompt() {
  local current_branch=$(git_current_branch)
  local branch_type_icon=$(iconize "e725")
  local bug_icon=$(iconize "f188")
  if [[ $current_branch =~ 'feature/' ]]; then
    current_branch=${current_branch//feature\//}
  elif [[ $current_branch =~ 'bugfix/' ]]; then
    current_branch=${current_branch//bugfix\//}
    branch_type_icon=$bug_icon
  fi
  local status_color=black
  echo " %F{$status_color}$branch_type_icon%f $current_branch "
}

rvm_prompt() {
  local icon=$(iconize "\ue21e")
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
  _prompt+=$(build_segment "$(path_prompt)" blue black)
  _prompt+=$(build_segment $(iconize "e0b0") yellow blue)
  _prompt+=$(build_segment "$(mode_prompt)" yellow)
  _prompt+=$(build_segment $(iconize "e0b0") transparent yellow)
  echo "${_prompt} "
}

build_right_prompt() {
  local _prompt=""
  if [[ -d "$(pwd)/.git" ]]; then
    _prompt+=$(build_segment $(iconize "e0b2") transparent green)
    _prompt+=$(build_segment "$(git_prompt)" green black)
    _prompt+=$(build_segment $(iconize "e0b2") green red)
  else
    _prompt+=$(build_segment $(iconize "e0b2") transparent red)
  fi
  _prompt+=$(build_segment "$(rvm_prompt)" red 008)
  echo -n "${_prompt}"
}

PROMPT='$(build_left_prompt)'
RPROMPT='$(build_right_prompt)'
