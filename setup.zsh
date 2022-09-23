#! /usr/bin/zsh
## _dotfiles setup script.

DOTFILES_REPO=${DOTFILES_REPO:-https://github.com/twinfacer/_dotfiles.git}
DOTDIR=${DOTDIR:-$HOME/.dotfiles}
CFG_PATH=$DOTDIR/config/

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

if which gh &>/dev/null; then
  gh auth status &>/dev/null
  gh_exit_status=$?
else
  gh_exit_status=1
fi

if [[ $gh_exit_status -eq 0 ]]; then
  git clone git@github.com:twinfacer/_dotfiles.git $DOTDIR &> /dev/null
else
  git clone --depth=1 $DOTFILES_REPO $DOTDIR &> /dev/null
fi

step "copy configs"
echo $CFG_PATH
echo $HOME
cp -R -v ~/.dotfiles/config/. $HOME/

source $HOME/.zshrc
