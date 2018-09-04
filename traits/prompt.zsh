#!/usr/bin/env zsh

setopt PROMPT_SUBST

colorize() {
  echo -n "%K{$2}%F{$3}$1%f%k"
}

build_segment() {
  local segment=$(colorize "$1" $2 $3)
  echo "$segment"
}

# promt parts
mode_prompt() {
  local icon=$(echo -e "\ue795")
  echo " $icon "
}

path_prompt() {
  local icon=$(echo -e "\ue5ff")
  local replacer="$icon "
  local current_path=$(pwd | sed "s:$HOME/:$replacer:")
  echo " $current_path "
}

git_prompt() {
  local icon=$(echo -e "\ue725")
  local git_current=$(git_current_branch)
  echo " $icon $git_current "
}

rvm_prompt() {
  local icon=$(echo -ne "\ue21e")
  local ruby_version=$(rvm-prompt | sed -e s/ruby-// -e s/-latest//)
  echo " $icon $ruby_version "
}

build_left_prompt() {
  local _prompt=""
  _prompt+=$(build_segment "$(mode_prompt)" 008 blue)
  _prompt+=$(build_segment $(echo -e "\ue0b0") blue 008)
  _prompt+=$(build_segment "$(path_prompt)" blue 008)
  _prompt+=$(build_segment $(echo -e "\ue0b0") 008 blue)
  echo "${_prompt} "
}

build_right_prompt() {
  local _prompt=""
  if [[ -d "$(pwd)/.git" ]]; then
    _prompt+=$(build_segment $(echo -ne "\ue0b2") 008 green)
    _prompt+=$(build_segment "$(git_prompt)" green 008)
    _prompt+=$(build_segment $(echo -ne "\ue0b2") green red)
  else
    _prompt+=$(build_segment $(echo -ne "\ue0b2") 008 red)
  fi
  _prompt+=$(build_segment "$(rvm_prompt)" red 008)
  echo -n "${_prompt}"
}

PROMPT='$(build_left_prompt)'
RPROMPT='$(build_right_prompt)'
