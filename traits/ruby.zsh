_setup_bundler_aliases() {
  which bundle &>/dev/null || return

  # Primary alias
  alias b="bundle"
  # Bundle exec
  alias be="bundle exec"
}

_setup_rubygems_aliases() {
  which gem &>/dev/null || return

  alias rgl="gem list"
  alias rgi="gem install"
}

_setup_bundler_aliases
_setup_rubygems_aliases