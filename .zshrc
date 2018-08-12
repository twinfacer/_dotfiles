# enviroment
export LANG="en_US.UTF-8"
export DOTDIR="${HOME}/.dotfiles"
export GIT_EDITOR="nano"
export PATH="$PATH:$HOME/.rvm/bin"
# powerline9k prompt setup
POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs rvm)
POWERLEVEL9K_OS_ICON_FOREGROUND='081\'
POWERLEVEL9K_RVM_FOREGROUND='$DEFAULT_COLOR'
POWERLEVEL9K_RVM_BACKGROUND='red'
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_with_folder_marker"
POWERLEVEL9K_DIR_PACKAGE_FILES=(powerline.json)
POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER="true"

# CONNECTION BASED SETUP
# TODO: Move me out, allow moar customization accross mashines later
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
  export OS_ICON=$'\Uf300'
else
  export EDITOR='atom --wait'
  export OS_ICON=$'\Uf303'
  xset b off
  setxkbmap -option ctrl:nocaps
fi

# vendor libs/plugs
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -s "/usr/share/nvm/init-nvm.sh" ]] && source /usr/share/nvm/init-nvm.sh

# load managed external plugins
ZPLUG_HOME=$DOTDIR/.zplug
source "$ZPLUG_HOME/init.zsh"

zplug "mfaerevaag/wd", as:command, use:"wd.sh", hook-load:"wd() { . $ZPLUG_REPOS/mfaerevaag/wd/wd.sh }"
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

if ! zplug check --verbose; then
    echo ">> zplug: some plugins not installed"
    zplug install && zplug load
else
  echo ">> zplug: all as up to date"
  zplug load
fi

# load everything from lib
for config_file ($DOTDIR/lib/*.zsh); do
  [ -f "${config_file}" ] && source $config_file
done

# # monkeypatch rvm prompt segment for powerlevel9k
# prompt_rvm() {
#   local ruby_version=$(rvm-prompt)
#
#   if [[ -n "$ruby_version" ]]; then
#     "$1_prompt_segment" "$0" "$2" "grey35" "$DEFAULT_COLOR" "${ruby_version/ruby-}" 'RUBY_ICON'
#   fi
# }

# Load aliases
source "$DOTDIR/aliases.zsh"

# load locals config last
for config_file ($DOTDIR/local/*.zsh); do
  [ -f "${config_file}" ] && source $config_file
done
