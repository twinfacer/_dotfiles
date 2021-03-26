# rubygems
alias rgl="gem list"
alias rgi="gem install"

# rbenv
which rbenv &>/dev/null || return

eval "$(rbenv init -)"

export PATH="$HOME/.rbenv/bin:$PATH"

alias r="rbenv"
alias rl="rbenv versions"
alias rlk="rbenv install -L"
alias ru="rbenv local"
alias ru!="rbenv global"
alias ri="rbenv install"
alias rr!="rbenv uninstall"
