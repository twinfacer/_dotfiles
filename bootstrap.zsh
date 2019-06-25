# enviroment
export PATH="$PATH:$DOTDIR/bin"

# default tools
export EDITOR="nano"
export VISUAL="atom"
export GIT_EDITOR="nano"
export DEFAULT_BROWSER="firefox"

source_dir() {
  [ -d $1 ] || return
  for source_file ($1/*.zsh); do
    [ -f $source_file ] && source $source_file
  done
}

# load all stuff in order
source_dir $DOTDIR/lib
source_dir $DOTDIR/traits
source_dir $DOTDIR/local

# replace default apps if any override found
export EDITOR=${EDITOR:-$DEFAULT_EDITOR}
export VISUAL=${VISUAL:-$DEFAULT_VISUAL}
export BROWSER=${BROWSER:-$DEFAULT_BROWSER}

clear

echo "$(pp "=>" yellow) $(pp "\ufb82" 40) connected as $(pp $USER cyan) on $(pp $HOST white) hive $(pp $(_conn_type) 75)"
