#!/usr/bin/sh

# setup.sh - one script for dev machine setup
# Works with manjaro (possibly - with archlinux) with xfce4 DE.

# setup.sh requires root/sudo access to modify some system confs.
# Please, review this file manually to confirm that it contains no malicious code!
if ! [ $(id -u) = 0 ]; then
  echo "The script need to be run as root." >&2
  exit 1
fi

# save real user for later
if [ $SUDO_USER ]; then
  real_user=$SUDO_USER
else
  real_user=$(whoami)
fi

## System setup
# Passwordless sudo
cp /etc/sudoers /etc/sudoers.backup
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Add user to wheel group which now have passwordless sudo 
usermod -G wheel $real_user

# Make pacman/yay use colors
sed -ie "s|#Color|Color|" /etc/pacman.conf

# Install package manager yay
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

## Install packages via yay
# TODO


## User setup
# Change shell to zsh 
# TODO: Change shell only if nessesary
chsh -s $(which zsh) $real_user
# TODO: To apply this changes shell session should be ended?

# Apply my .dotfiles
# TODO: Check how in works
curl -L "https://git.io/fNdqS" | zsh

# Create directory for projects
mkdir ~/projects

# Generate ssh-keypair for github access
# TODO: Do it if nessesary
ssg && ssc

# Clone fresh copy of my dotfiles into projects directory
gcl git@github.com:twinfacer/_dotfiles.git

# Make warp point (via wd)
wda dot  





