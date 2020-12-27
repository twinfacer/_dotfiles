#!/usr/bin/sh

# setup.sh - one script for dev machine setup
# Works with manjaro (possibly - with archlinux) with xfce4 DE.

# setup.sh requires root/sudo access to modify some system confs
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

# Make pacman use colors
sed -ie "s|#Color|Color|" /etc/pacman.conf
# Install package manager yay
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Install packages via yay

## User setup
# Change shell to zsh 
chsh -s $(which zsh) $real_user
# TODO: To apply this changes shell session should be ended. 

# Apply my .dotfiles
curl -L "https://git.io/fNdqS" | zsh

# Create directory for projects
take ~/projects

# Generate ssh-keypair for github access
ssg && ssc

# Clone fresh copy of my dotfiles into projects directory
gcl git@github.com:twinfacer/_dotfiles.git

# Make warp point (via wd)
wda dot  





