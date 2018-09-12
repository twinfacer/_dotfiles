# enviroment
export DOTDIR="${HOME}/.dotfiles"
export EDITOR="nano"
export VISUAL="atom"
export GIT_EDITOR="nano"
export PATH="$PATH:$DOTDIR/bin"

source_dir() {
  [ -d $1 ] || return
  for source_file ($1/*.zsh); do
    [ -f $source_file ] && source $source_file
  done
}

# load all stuff
source_dir $DOTDIR/lib
source_dir $DOTDIR/traits
source_dir $DOTDIR/local

clear
echo "$(pp "=>" yellow) $(pp "\ufb82" 40) connected as $(pp $USER cyan) on $(pp $HOST white) hive"
