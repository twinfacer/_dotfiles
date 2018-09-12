### Git aliases
# add
alias ga='git add'
alias gaa='git add .; git status -s'
alias gae='git add -e'
# branch
alias gb='git --no-pager branch'
alias gbl='gb -l'
# checkout
alias gc='git checkout'
alias gcb='git checkout -b'
# commit
alias gcm='git commit -m'
# diff
alias gd='git diff --color'
alias gdc='git diff --color --cached HEAD'
# log
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# pull
alias gref='git pull -r origin dev'
# push
alias gpush='git push origin $(git_current_branch)'
alias gpush!='git push -f origin $(git_current_branch)'
# reset
alias grt='git reset'
alias grt!='git reset --hard'
# rebase
alias grbi="git rebase -i"
alias grbc="git rebase --continue"
alias grba="git rebase --abort"
# show
alias gsh='git show'
# status
alias gst='git status -s'

alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null git commit --no-verify -m "--wip-- [skip ci]"'