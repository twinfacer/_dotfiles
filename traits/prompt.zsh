setopt PROMPT_SUBST

export DEFAULT_LEFT_SEGMENTS=(status path)
export DEFAULT_RIGHT_SEGMENTS=(git nvm rbenv)

left_separator_prompt() { icon "l_prompt" }

right_separator_prompt() { icon "r_prompt" }

export STATUS_PROMPT_BG_COLOR="yellow"

status_prompt() {
  if [[ $PROMPT_LAST_STATUS -eq 0 ]]; then
    local color=008;
  else
    local color=red;
  fi
  echo " %F{$color}$(icon "status")%f "
}

export PATH_PROMPT_BG_COLOR="blue"

path_prompt() {
  echo " $(pwd | sed "s:$HOME:~:") "
}

export GIT_PROMPT_BG_COLOR="green"

git_prompt() {
  if [[ -d "./.git" ]]; then
    local current_branch=$(git_current_branch)
    local branch_type_icon=$(icon "git_branch")
    if [[ $current_branch =~ 'feature/' ]]; then
      current_branch=${current_branch//feature\//}
      branch_type_icon=$(icon "git_branch")
    elif [[ $current_branch =~ 'bugfix/' ]]; then
      current_branch=${current_branch//bugfix\//}
      branch_type_icon=$(icon "bug")
    fi
    if [[ -n $(git status -s) ]]; then
      local status_color=red
    else
      local status_color=black
    fi
    echo " %F{$status_color}$branch_type_icon%f %F{black}$current_branch%f "
  else
    echo ""
  fi
}

export RVM_PROMPT_BG_COLOR="red"

rvm_prompt() {
  if [[ -d $HOME/.rvm ]]; then
    local ruby_version=$(rvm-prompt | sed -e s/ruby-// -e s/-latest//)
    echo " $(icon "ruby") $ruby_version "
  else
    echo ""
  fi
}

export RBENV_PROMPT_BG_COLOR="red"

rbenv_prompt() {
  if [[ -d $HOME/.rbenv ]]; then
    local ruby_version=$(rbenv local 2>/dev/null | grep -o -E '[0-9]+.[0-9]+.[0-9]+')
    if [[ -z $ruby_version ]]; then ruby_version=$(rbenv global 2>/dev/null | grep -o -E '[0-9]+.[0-9]+.[0-9]+'); fi
    echo " $(icon "ruby") $ruby_version "
  else
    echo ""
  fi
}

export NVM_PROMPT_BG_COLOR="yellow"

nvm_prompt() {
  if [[ -d $HOME/.nvm ]]; then
    echo -n "$(icon "js_icon") $(nvm current | sed -e s/v//) "
  else
    echo ""
  fi
}

build_segment() {
  echo $(colorize "$($1_prompt)" $2 $3)
}

build_prompt() {
  export PROMPT_LAST_STATUS=$?
  local position=$1
  local _prompt=""
  local segments_varname=${(U)position}_SEGMENTS
  local default_segments_varname=DEFAULT_${segments_varname}
  segments=(${${(P)segments_varname}:-${(P)default_segments_varname}})
  for index in {1..${#segments[@]}}; do
    local segment_name=${segments[$index]}
    local fg_varname=${(U)segment_name}_PROMPT_FG_COLOR
    local bg_varname=${(U)segment_name}_PROMPT_BG_COLOR
    local segment_fg=${${(P)fg_varname}:-008}
    local segment_bg=${${(P)bg_varname}:-blue}
    local segment=$(build_segment $segment_name $segment_bg $segment_fg)
    if [[ -z $segment ]]; then
      echo "empty!"
    else
      if [[ $index == 1 && $position == 'right' ]]; then
        _prompt+="$(build_segment right_separator transparent $segment_bg)"
      fi
      _prompt+="$segment"
      if [[ $index == ${#segments[@]} ]]; then
        if [[ $position == 'left' ]]; then
          _prompt+="$(build_segment left_separator transparent $segment_bg) "
        fi
      else
        next_segment_name=${segments[$(($index + 1))]}
        next_bg_varname=${(U)next_segment_name}_PROMPT_BG_COLOR
        next_segment_bg=${${(P)next_bg_varname}:-blue}
        if [[ $position == 'left' ]]; then
          _prompt+="$(build_segment ${position}_separator $next_segment_bg $segment_bg)"
        else
          _prompt+="$(build_segment ${position}_separator $segment_bg $next_segment_bg )"
        fi
      fi
    fi
  done
  echo -n "${_prompt}"
}

PROMPT='$(build_prompt left)'
RPROMPT='$(build_prompt right)'
