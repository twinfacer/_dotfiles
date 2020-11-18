# Rails aliases
alias rc="rails console"
alias rs="rails server"
alias rr="rails routes"
alias rdm="rails db:migrate"
alias rgm="rails generate migration"

alias dbup="rake db:create db:migrate db:seed"
alias dbup!="rake db:drop db:create db:migrate db:seed"

alias -g L3="localhost:3000"

function _show_coverage() {
  coverage_file=$(pwd)/coverage/index.html
  [ -f $coverage_file ] || (echo "No coverage file found!" && return)
  $BROWSER $coverage_file >/dev/null
}

alias cov="_show_coverage"
alias tt="bundle exec rspec"

export LOCALIZED_GEM_PREFIX=${LOCALIZED_GEM_PREFIX:-~/projects/}

localize() {
  sed -i -e "s|gem '$1'|gem '$1', path: '$LOCALIZED_GEM_PREFIX$1' #|" Gemfile
}

delocalize() {
  sed -i -e "s|gem '$1', path: '$LOCALIZED_GEM_PREFIX$1' #|gem '$1'|" Gemfile
}

upd() {
  localize $1
  bundle install
  delocalize $1
  bundle install
}
