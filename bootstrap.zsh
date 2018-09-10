# enviroment
export DOTDIR="${HOME}/.dotfiles"
export EDITOR="nano"
export VISUAL="atom"
export GIT_EDITOR="nano"
export PATH="$PATH:$DOTDIR/bin"

source_dir() {
  for source_file ($1/*.zsh); do
    [ -f $source_file ] && source $source_file
  done
}

colorize_fg() {
  print -P "%F{$2}$1%f"
}

wd() {
  . $DOTDIR/bin/wd
}

# load all stuff
source_dir $DOTDIR/lib
source_dir $DOTDIR/traits
source_dir $DOTDIR/local

echo "$(colorize_fg "\ufb82" green) Symbiont connection established for $(colorize_fg $USER cyan) on $(colorize_fg $HOST white)"
