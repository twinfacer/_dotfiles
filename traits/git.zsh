# Global aliases
alias -g hd='HEAD'
alias -g mt='master'

# Allows to quickly dig up to 9 levels of commits with h1-h9 global aliases.
for (( i = 1; i < 10; i++ )); do
  alias -g "h$i"="HEAD~$i"
done

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

# bisect
alias gbs="git bisect"
alias gbss="git bisect start"
alias gbsb="git bisect bad"
alias gbsg="git bisect good"
alias gbsr="git bisect reset"

# checkout
alias gc='git checkout'
alias gcb='git checkout -b'

_git_checkout_feature() {
  git checkout -b feature/$1
}

alias gcf='_git_checkout_feature'
alias gcmt='git checkout master'

# cherry-pick
alias gcp='git cherry-pick'

# clone
_git_clone_and_cd() {
  git clone $1 && cd $(basename $1 .git)
}
alias gcl='_git_clone_and_cd'

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

# remote
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

# misc
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'

_add_git_hook() {
	local src_path="$DOTDIR/templates/hooks/$1.sh"
	local dest_path=".git/$1"

	[ -d ".git" ] || echo "=> No git repo found!"
	[ -f $src_path ] || echo "=> No hook named `$1` found!" && return 1
	[ -f $dest_path ] || echo "=> Hook named `$1` already found!" && return 1
	cp $src_path $dest
}

alias bumper_hook='_add_git_hook'
