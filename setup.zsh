#! /usr/bin/zsh

# toolbox
function say() {
  local mgs = $1
  echo "=> $msg"
}

function die() {
  local msg = $1
  say $msg
  exit 0
}

function backup() {
  say "$1 found, backuping it"
  mv $1 "$1.$(date +%s).bak"
}

DOTDIR=${DOTDIR:-$HOME/.dotfiles}
say "installation path: ${DOTDIR}"

say "repo: cloning"
if [[ $(ls -A $DOTDIR 2>/dev/null | wc -l) -gt 0 ]]; then
  local overwrite_dotdir
  vared -p "$DOTDIR is not empty! remove it contents and continue? : " overwrite_dotdir
  if [[ $overwrite_dotdir == 'y' ]]; then
    rm -rf $DOTDIR
  else
    die "fatal: cannot clone git repo"
  fi
fi
git clone --depth=1 https://github.com/twinfacer/_dotfiles.git $DOTDIR

say "configs: symlinking"
for source_file ($1/**/*); do
  local $target_file = ${source_file/$1/$2/}
  [ -f $target_file ] && backup $target_file
  ln -s $source_file $target_file
done

source $HOME/.zshrc
