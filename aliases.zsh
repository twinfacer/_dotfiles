# ALIASES
alias p="echo"
alias h="man"
alias m="mount"

alias yo="yaourt"
alias ll="ls -lAhF"
alias sc="systemctl"
alias ed="${EDITOR}"
# ZSH
alias zconf="ed ${ZDOTDIR}/.zshrc"
alias dconf=""
alias zref="source ${ZDOTDIR}/.zshrc; clear"

alias tconf="ed ~/.tmux.conf"
alias cov='firefox coverage/index.html >/dev/null'
# Let's warp around like a pro
alias warp="wd"
alias wp="wd"
alias wpl="wd list"
alias wpa="wd add"

alias nuke="rm -rf"
alias yolo="sudo"

alias -g reverse="sed '1!G;h;$!d'"

alias spawn_tab="xdotool key ctrl+shift+t"

# Git aliases
alias gst="git status -s"
alias gd="git diff --color"
alias gdc="git diff --color --cached HEAD"
alias gc="git checkout"
alias gcb="git checkout -b"
alias gaa="git add .; git status -s"
alias gap="git add -p"
alias gae="git add -e"
alias gwip="git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m '--wip-- [skip ci]'"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# git branch
alias gb="git --no-pager branch"
alias gbl="gb -l"
alias gbm="gb -m"
alias gbd="gb -d"
alias gbm!="gb -M"
alias gbd!="gb -D"

# Rails aliases
alias rc="rails console"
alias rs="rails server"
alias rr="rails routes"
alias rdm="rails db:migrate:with_data"
alias rgm="rails generate migration"
