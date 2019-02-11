_refresh_dotfiles() {
  cd $DOTDIR
  git pull origin master &> /dev/null
}

alias dref="_refresh_dotfiles()"
