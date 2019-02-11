_refresh_dotfiles() {
  local return_dir=$(pwd)
  cd $DOTDIR
  git pull origin master &> /dev/null
  cd $return_dir
}

alias dref="_refresh_dotfiles()"
