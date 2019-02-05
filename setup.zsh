#! /usr/bin/zsh

# toolbox
colorify() {
  echo "%F{$2}$1%f"
}

say() {
  print -P "$(colorify "=>" yellow) $1"
}

backup() {
  say "old $1 found, backuping it"
  mv $1 "$1.$(date +%s).bak"
}

DOTDIR=${DOTDIR:-$HOME/.dotfiles}
say "installation path: ${DOTDIR}"

say "$(colorify repo orange): cloning"
if [[ $(ls -A $DOTDIR 2>/dev/null | wc -l) -gt 0 ]]; then
  local overwrite_dotdir
  vared -p "$DOTDIR is not empty! remove it contents and continue? : " overwrite_dotdir
  if [[ $overwrite_dotdir == 'y' ]]; then
    rm -rf $DOTDIR
  else
    say $(colorify "fatal: cannot clone git repo" red) && exit 0
  fi
fi
git clone --depth=1 https://github.com/twinfacer/_dotfiles.git $DOTDIR 2>&1 1>/dev/null

say "$(colorify repo orange): symlinking"
for source_file ($DOTDIR/config/**/*(.D)); do
  target_file = $(echo $source_file | sed -e "s:$DOTDIR/config:$HOME:")
  [ -f $target_file ] && backup $target_file
  ln -sf $source_file $target_file
done

source $HOME/.zshrc
