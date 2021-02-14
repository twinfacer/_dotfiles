# enviroment
export PATH="$PATH:$DOTDIR/bin"

# default tools
export DEFAULT_EDITOR="nano"
export DEFAULT_VISUAL="atom"
export DEFAULT_BROWSER="firefox"
export DEFAULT_GIT_EDITOR="nano"

source_dir() {
  [ -d $1 ] || return
  [[ ! -z $(ls $1) ]] || return
  for source_file ($1/*.zsh); do
    [ -f $source_file ] && source $source_file
  done
}

# load all stuff in order
[ -f $DOTDIR/init.zsh ] && source $DOTDIR/init.zsh
source_dir $DOTDIR/lib
source_dir $DOTDIR/traits
source_dir $DOTDIR/local

# Set default apps unless any override found (place 'em in init.zsh)
export EDITOR=${EDITOR:-$DEFAULT_EDITOR}
export VISUAL=${VISUAL:-$DEFAULT_VISUAL}
export BROWSER=${BROWSER:-$DEFAULT_BROWSER}
export GIT_EDITOR=${GIT_EDITOR:-$DEFAULT_GIT_EDITOR}

clear

echo "$(pp "=>" yellow) $(pp "\ufb82" 40) connected as $(pp $USER cyan) on $(pp $HOST white) hive $(pp $(_conn_type) 75)"
