alias -g hd='HEAD'
alias -g h1='HEAD~1'
alias -g mt='master'

# add
alias ga='git add'
alias gaa='git add .; git status -s'
alias gae='git add -e'
# branch
alias gb='git --no-pager branch'
alias gbl='gb -l'
alias gbr='git branch -d'
alias gbr!='git branch -D'
alias gbc='git branch -c'
alias gbc!='git branch -C'
alias gbm='git branch -m'
alias gbm!='git branch -M'
alias gbum="git branch --no-merged=master"
# checkout
alias gc='git checkout'
alias gcb='git checkout -b'
alias gcmt='git checkout master'
# cherry-pick
alias gcp='git cherry-pick'
# commit
alias gcm='git commit -m'
alias gcma='git commit -am'
alias gfix='git add . ; git commit --amend'
# diff
alias gd='git diff --color'
alias gdc='git diff --color --cached HEAD'
# fetch
alias gf='git fetch'
# log
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# pull
alias gref='git pull -r origin master'
# push
alias gpush='git push origin $(git_current_branch)'
alias gpush!='git push -f origin $(git_current_branch)'
# reflog
alias grl='git reflog'
# reset
alias grt='git reset'
alias grt!='git reset --hard'
# rebase
alias grb='git rebase'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grbs='git rebase --skip'
alias grba='git rebase --abort'
# remove
alias grm='git remote'
alias grma='git remote add'
alias grmr='git remote rename'
alias grmd='git remote remove'
alias grmv='git remote -v'
alias grmu='git remote get-url'
alias grmu!='git remote set-url'
# show
alias gsh='git show'
# status
alias gst='git status -s'
# stash
alias gss='git stash save -u'
alias gsl='git stash list'
alias gsa='git stash apply'
alias gsd='git stash drop'

alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'
