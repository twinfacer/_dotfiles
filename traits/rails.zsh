# Ruby on Rails aliases

# Rails console
alias rc="rails console"

# Rails server
alias rs="rails server"

# Rails routes
alias rr="rails routes"

# Rails create db
alias rdc="rails db:create"

# Rails migrate db
alias rdm="rails db:migrate"

# Rails drop db
alias rdd="DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rails db:drop"

# Rails generate migration
alias rgm="rails generate migration"

# Clear all rails caches
alias rtcc="rails tmp:cache:clear && rs"

function _show_coverage() {
  coverage_file=$(pwd)/coverage/index.html
  [ -f $coverage_file ] || (echo "No coverage file found!" && return)
  $BROWSER $coverage_file >/dev/null
}

# Show test coverage
alias cov="_show_coverage"

# Run rspec test
alias tt="bundle exec rspec"

## TODO: move me out
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
