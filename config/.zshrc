# enviroment
export DOTDIR="$HOME/.dotfiles"
export PATH="$PATH:$DOTDIR/bin"

# user customizations
[ -f $DOTDIR/local/init.zsh ] || cp $DOTDIR/templates/init.zsh $DOTDIR/local/init.zsh
source $DOTDIR/local/init.zsh

# Set default apps unless any override found
export EDITOR=${EDITOR:-nano}
export VISUAL=${VISUAL:-codium}
export BROWSER=${BROWSER:-vivaldi-stable}
export GIT_EDITOR=${GIT_EDITOR:-nano}

source_dir() {
  [ -d $1 ] || return
  [[ ! -z $(ls $1) ]] || return
  for source_file ($1/*.zsh); do
    [ -f $source_file ] && source $source_file
  done
}

# load all stuff in order
source_dir $DOTDIR/lib
source_dir $DOTDIR/traits
source_dir $DOTDIR/local

echo "$(pp "=>" yellow) $(pp "\ufb82" 40) connected as $(pp $USER cyan) on $(pp $HOST white) hive"
