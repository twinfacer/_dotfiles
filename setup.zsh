#! /usr/bin/zsh
## _dotfiles setup script.

DOTFILES_REPO=${DOTFILES_REPO:-https://github.com/twinfacer/_dotfiles.git}
DOTDIR=${DOTDIR:-$HOME/.dotfiles}

source_url() {
  source <(curl -s $1)
}

source_url "https://raw.githubusercontent.com/twinfacer/_dotfiles/master/lib/icons.zsh"
source_url "https://raw.githubusercontent.com/twinfacer/_dotfiles/master/lib/output.zsh"

info "installation path: ${DOTDIR}"
step "cloning git repository"

if [[ -d $DOTDIR ]]; then
  local overwrite_dotdir
  vared -p "$fg[red][!] $DOTDIR is not empty! remove it contents and continue? : (y/n) $reset_color" overwrite_dotdir
  if [[ $overwrite_dotdir == 'y' ]]; then
    rm -rf $DOTDIR
  else
    error "fatal: clone git repo aborted!" && exit 1
  fi
fi

# TODO: Clone via ssh if available!
git clone --depth=1 $DOTFILES_REPO $DOTDIR &> /dev/null

step "copy configs"
cp -r --backup $DOTDIR/config/* ~/

source $HOME/.zshrc
