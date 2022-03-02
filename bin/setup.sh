#!/bin/sh
# setup.sh - One script for post install configuration.
# Written by @twinfacer 2021-2022 (C)

# we need root
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

## GENERIC SETUP (LINUX/ARCHLINUX)

# 1) Enable NTP if not already enabled.
_enable_ntpd() {
  echo "[*] Enabling NTP service"
  systemctl enable ntpd
  systemctl start ntpd
}

systemctl status ntpd &>/dev/null || _enable_ntpd

# 2) Update system via pacman
echo "[*] Updating system"
pacman -Syu --noconfirm &>/dev/null

# 3) Install yay - AUR helper
_install_yay() {
  echo "[*] Installing yay"
  pacman -Syu --needed --noconfirm yay &>/dev/null
}

which yay &>/dev/null || _install_yay

# 4) Enable passwordless sudo
magic_string="%wheel ALL=(ALL) NOPASSWD: ALL"

_enable_passwordless_sudo() {
  echo "[*] Enabling passwordless sudo"
  echo $magic_string >> /etc/sudoers
  usermod -G wheel $real_user
}

[[ $(sudo tail -n 1 /etc/sudoers) == $magic_string ]] || _enable_passwordless_sudo

# 5) make pacman/yay use colors
_setup_pacman() {
  echo "[*] Pacman colors setup"
  sed -ie "s|#Color|Color|" /etc/pacman.conf
}

grep "#Color" /etc/pacman.conf &>/dev/null && _setup_pacman

# TODO: Key is generated with root username =)
# 6) generate ssh key-pair if nessesary
_setup_ssh() {
  echo "[*] Generating ssh keys"
  [[ -d /home/$real_user/.ssh ]] || mkdir /home/$real_user/.ssh
  ssh-keygen -t rsa -b 4096 -f /home/$real_user/.ssh/id_rsa -N ''
  chown -R $real_user:$real_user /home/$real_user/.ssh
}

[[ -f /home/$real_user/.ssh/id_rsa.pub ]] || _setup_ssh

# 7) Packages sync via yay
packages=(
  base-devel htop tmux zsh gnu-netcat xclip bat python2 nerd-fonts-hack
  sublime-merge deluge vivaldi atom sublime-text-4 meld
  flameshot postman-bin rbenv ruby-build postgresql android-studio
  obsidian yarn vlc ventoy gimp
  nmap gobuster swaks rkhunter
)

# TODO: Silence 'em
_sync_packages() {
  echo "[*] Syncing packages"
  cmd="yay -S --noconfirm --needed ${packages[@]} &>/dev/null"
  su -c "$cmd" - $real_user
}

_sync_packages

_cleanup_manjaro() {
  pacman -Rsu manjaro-hello manjaro-documentation-en gnome-disk-utility lollypop pidgin gnome-screenshot imagewriter thunderbird transmission-gtk uget totem  &>/dev/null
}

_cleanup_manjaro()

# 8) setup zsh
_setup_zsh() {
  echo "[*] Changing shell to zsh"
  chsh -s $(which zsh) $real_user &>/dev/null
  echo "[!] You need to relogin in order to switch shell!"
}

[[ $(getent passwd $real_user | cut -d: -f7) == $(which zsh) ]] || _setup_zsh

# copy wallpaper for terminal
bg_path="https://hdwallpaperim.com/wp-content/uploads/2017/08/25/126048-Magic_The_Gathering-Elesh_Norn.jpg"
curl -s -L $bg_path > /home/$real_user/terminal_bg.jpg


# setup postgresql
_setup_postgresql() {
  echo "[*] Initializin postgresql DB"
  systemctl enable postgresql
  su - postgres -c "initdb --locale en_US.UTF-8 -D '/var/lib/postgres/data'"
  systemctl start postgresql
}

systemctl status postgresql &>/dev/null || _setup_postgresql

# setup dotfiles
_setup_dotfiles() {
  echo "[*] setup .dotfiles"
  export DOTDIR=/home/$real_user/.dotfiles
  cmd="curl -L 'https://git.io/fNdqS' | zsh"
  su -c "$cmd" $real_user
}

# TODO: We may need to update dotfiles if needed.
[[ -d /home/$real_user/.dotfiles ]] || _setup_dotfiles

# Create projects dir
[[ -d /home/$real_user/projects ]] || mkdir /home/$real_user/projects && chown $real_user /home/$real_user/projects

# setup atom
_setup_atom() {
  echo "[*] setup atom via apm"
  su -c "apm install -s file-icons git-blame scratch language-pug language-slim language-vue &>/dev/null" $real_user
}

which apm &>/dev/null && _setup_atom

# TODO: add ru layout && change switch layout key
# setxkbmap -layout us,ru

echo "[*] done!"
