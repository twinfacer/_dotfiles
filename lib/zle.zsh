### ZSH Line editor (aka ZLE) config

# Less typing - moar time for having fun!
setopt auto_cd
# Sometimes we wanna to paste something that can contains comments, right?
setopt interactive_comments
# Removes pesky last space at right prompt
ZLE_RPROMPT_INDENT=0
# Use emacs key bindings
bindkey -e
# [Esc-w] - Kill from the cursor to the mark
bindkey '\ew' kill-region
# [Esc-r] - Reload
bindkey -s '\er' "source ~/.zshrc; clear ^M"
# start typing + [Up-Arrow] - fuzzy find history forward
bindkey '\e[B' history-search-forward
# start typing + [Down-Arrow] - fuzzy find history backward
bindkey '\e[A' history-search-backward
# [Home] - Go to beginning of line
if [[ "${terminfo[khome]}" != "" ]]; then bindkey "${terminfo[khome]}" beginning-of-line; fi
# [End] - Go to end of line
if [[ "${terminfo[kend]}" != "" ]]; then bindkey "${terminfo[kend]}"  end-of-line; fi
# [Space] - do history expansion
bindkey ' ' magic-space
# [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey '^[[1;5D' backward-word
# [Shift-Tab] - move through the completion menu backwards
if [[ "${terminfo[kcbt]}" != "" ]]; then bindkey "${terminfo[kcbt]}" reverse-menu-complete; fi
# [Backspace] - delete backward
bindkey '^?' backward-delete-char
# [Delete] - delete forward
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char
else
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi

# file rename magick
bindkey "^[m" copy-prev-shell-word
