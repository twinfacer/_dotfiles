# TODO: Add guard against rvm absense
# TODO: Add completion for `use`


export PATH="$PATH:$HOME/.rvm/bin/"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

alias r="rvm"
alias rl="rvm list"
alias rlk="rvm list known"
alias ru="rvm use"
alias ru!="rvm use --default"
