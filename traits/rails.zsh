# Rails aliases
alias rc="rails console"
alias rs="rails server"
alias rr="rails routes"

alias rdc="rails db:create"
alias rdm="rails db:migrate"
alias rdd="rails db:drop"
alias rgm="rails generate migration"

alias rtcc="rails tmp:cache:clear && rs"

function _show_coverage() {
  coverage_file=$(pwd)/coverage/index.html
  [ -f $coverage_file ] || (echo "No coverage file found!" && return)
  $BROWSER $coverage_file >/dev/null
}

alias cov="_show_coverage"
alias tt="bundle exec rspec"

# Manual gems localization
export LOCALIZED_GEM_PREFIX=${LOCALIZED_GEM_PREFIX:-~/projects/}

localize() {
  sed -i -e "s|gem '$1'|gem '$1', path: '$LOCALIZED_GEM_PREFIX$1' #|" Gemfile
}

delocalize() {
  sed -i -e "s|gem '$1', path: '$LOCALIZED_GEM_PREFIX$1' #|gem '$1'|" Gemfile
}

upd() {
  for gem; do; localize $gem; done
  bundle install
  for gem; do; delocalize $gem; done
  bundle install
}
