# rubygems
alias rgl="gem list"
alias rgi="gem install"

# rbenv
[[ -d $HOME/.rbenv ]] || return

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

alias r="rbenv"
alias rl="rbenv versions"
alias rlk="rbenv install -L"
alias ru="rbenv local"
alias ru!="rbenv global"
alias ri="rbenv install"
alias rr!="rbenv uninstall"
