# Installation
\curl -sSL https://get.rvm.io | bash -s stable

# Enable completitions for zsh
mkdir -p $HOME/.zsh/Completion
cp $rvm/scripts/zsh/Completion/_rvm $HOME/.zsh/Completion
echo 'fpath=(~/.rvm/scripts/zsh/Completion $fpath)' >> $HOME/.zshrc
