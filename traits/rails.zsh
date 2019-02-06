# Rails aliases
alias rc="rails console"
alias rs="rails server"
alias rr="rails routes"
alias rdm="rails db:migrate"
alias rgm="rails generate migration"

function _show_coverage() {
  coverage_file=$(pwd)/coverage/index.html
  [ -f $coverage_file ] || (echo "No coverage file found!" && return)
  firefox $coverage_file >/dev/null
}

alias cov="_show_coverage"
