# Rails aliases
alias rc="rails console"
alias rs="rails server"
alias rr="rails routes"
alias rdm="rails db:migrate"
alias rgm="rails generate migration"

alias -g L3="localhost:3000"

function _show_coverage() {
  coverage_file=$(pwd)/coverage/index.html
  [ -f $coverage_file ] || (echo "No coverage file found!" && return)
  $BROWSER $coverage_file >/dev/null
}

alias cov="_show_coverage"
alias tt="bundle exec rspec"
