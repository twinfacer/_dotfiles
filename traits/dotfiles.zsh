# .dotfiles managment utilities

_extract_semver() {
  grep -E -o '[0-9]+.[0-9]+.[0-9]+'
}

_get_dotfiles_local_version() {
  head -n 1 $DOTDIR/README.md | _extract_semver
}

_get_dotfiles_remote_version() {
  local remote_path="https://raw.githubusercontent.com/twinfacer/_dotfiles/master/README.md"
  curl -s $remote_path | head -n 1 - | _extract_semver
}

_check_versions() {
  echo "Local: ${_get_dotfiles_local_version}; Remote: ${_get_dotfiles_remote_version}"
}

_refresh_dotfiles() {
  # TODO: add guard with version check
  local return_dir=$(pwd)
  cd $DOTDIR
  git pull origin master &> /dev/null
  cd $return_dir
}

alias dref="_refresh_dotfiles"
