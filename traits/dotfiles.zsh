# .dotfiles managment utilities

_extract_semver() {
  grep -E -o '[0-9]+.[0-9]+.[0-9]+'
}

_get_dotfiles_local_version() {
  head -n 1 $DOTDIR/README.md | _extract_semver
}

_get_dotfiles_remote_version() {
  local remote_path='https://raw.githubusercontent.com/twinfacer/_dotfiles/master/README.md'
  curl -s $remote_path | head -n 1 - | _extract_semver
}

_check_versions() {
  echo "Local: $(pp $(_get_dotfiles_local_version) red); Remote: $(pp $(_get_dotfiles_remote_version) green)"
}

_refresh_dotfiles() {
  local old=$(_get_dotfiles_local_version)
  local new=$(_get_dotfiles_remote_version)
  if [ $old = $new ]; then
    echo "No update required! Latest version $(pp $new green) already installed"
  else
    local return_dir=$(pwd)
    cd $DOTDIR
    # TODO: add guard if $DOTDIR is dirty
    git pull origin master &> /dev/null
    cp -r config/* ~/
    cd $return_dir
    source ~/.zshrc
    clear
    # TODO: Find out why dquotes behaves so unexpectingly
    echo Version $(pp $new green) successfully installed!
  fi
}

alias dcomp="_check_versions"
alias dref="_refresh_dotfiles"
