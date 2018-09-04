# enviroment
export DOTDIR="${HOME}/.dotfiles"
export EDITOR="nano"
export VISUAL="atom"
export GIT_EDITOR="nano"
export PATH="$PATH:$DOTDIR/bin"
export TMUX_DEFAULT_SESSION="system"

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

# jump to `default` tmux session
if [[ -z "$TMUX" ]];then
  tmux has-session -t $TMUX_DEFAULT_SESSION || tmux new-session -s $TMUX_DEFAULT_SESSION
  tmux attach-session -t $TMUX_DEFAULT_SESSION
fi
