#!/usr/bin/env /bin/bash
# This is cygwin post-install script

# Install packages manager - `apt-cyg`
lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg
install apt-cyg /bin
rm apt-cyg

# Now, install everything else with it
apt-cyg install wget curl zsh git

# Make zsh default shell
mkpasswd -c | sed -e 'sX/bashX/zshX' | tee -a /etc/passwd

# Configure `git`
git config --global core.filemode false
git config --global user.email "twinfacer@gmail.com"
git config --global user.name "Twinfacer"

# Get nerd font
# https://github.com/twinfacer/my-nerd-fonts/raw/master/Consolas%20NF/Consolas%20Bold%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf

# Install dotfiles
curl -L "https://git.io/fNdqS" | zsh
