#! /usr/bin/zsh

DOTDIR=${DOTDIR:-$HOME/.dotfiles}
echo ">> installation path: ${DOTDIR}"

# clone repo to dotfiles directory
echo ">> cloning main repo"
if [[ $(ls -A $DOTDIR | wc -l) -gt 0 ]]; then
  echo "!! ${DOTDIR} is not empty!"
  vared -p "?? remove it contents and continue? " -c overwrite_dotdir
  if [[ $overwrite_dotdir == 'y' ]]; then
    rm -rf $DOTDIR
  else
    echo "!! error"
    exit 0
  fi
fi
git clone git@github.com:twinfacer/_dotfiles.git $DOTDIR
cd $DOTDIR

# copy our sane default configs
echo ">> copying default dotfiles"
# TODO: Backup files before overwriting them
cp cfg/**/* $HOME

# install zplug
export ZPLUG_HOME=$DOTDIR/.zplug
echo ">> installing zplug into $ZPLUG_HOME"
git clone --depth=1 https://github.com/zplug/zplug $ZPLUG_HOME

# # initial zplug start
# echo ">> zplug install"
# source $DOTDIR/plugins.zsh

# bootstrap
# TODO: backup && clean other zsh stuff as well
echo ">> configuring bootstrap"
mv $HOME/.zshrc $HOME/.zshrc.bak

echo "DOTDIR=${DOTDIR}" >> $HOME/.zshrc
echo "source ${DOTDIR}/.zshrc" >> $HOME/.zshrc

# TODO: auto restart
echo ">> success, restart to see effect"
