# rubygems
alias rgl="gem list"
alias rgi="gem install"

# rbenv
[[ -d $HOME/.rbenv ]] || return

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

## Obsolete at 05-02-2021

# Ruby enVironment Manager aka RVM
# TODO: Add completion for `use`
# [[ -d $HOME/.rvm ]] || return

# export PATH="$PATH:$HOME/.rvm/bin/"

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# alias r="rvm"
# alias rl="rvm list"
# alias rlk="rvm list known"
# alias ru="rvm use"
# alias ru!="rvm use --default"
# alias ri="rvm install"
# alias rr!="rvm reinstall"
# alias rd!="rvm remove"
