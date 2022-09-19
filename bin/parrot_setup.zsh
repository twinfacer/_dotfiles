#!/usr/bin/zsh
#
# setup_parrot.zsh - One script for post install configuration.
# Written by @twinfacer 2021-2022 (C)

# we need root
if ! [ $(id -u) = 0 ]; then
  echo "[!] The script need to be run as root." >&2
  exit 1
fi

# save real user for later
if [ $SUDO_USER ]; then
  real_user=$SUDO_USER
else
  real_user=$(whoami)
fi

## GENERIC SETUP LINUX

# Enable NTP if not already enabled.
_enable_ntpd() {
  echo "[*] Enabling NTP service"
  systemctl enable ntpd  &>/dev/null
  systemctl start ntpd  &>/dev/null
}

systemctl status ntpd &>/dev/null || _enable_ntpd

# Enable passwordless sudo
magic_string="%wheel ALL=(ALL) NOPASSWD: ALL"

_enable_passwordless_sudo() {
  echo "[*] Enabling passwordless sudo"
  echo $magic_string >> /etc/sudoers
  usermod -G wheel $real_user
}

[[ $(sudo tail -n 1 /etc/sudoers) == $magic_string ]] || _enable_passwordless_sudo


# TODO: Key is generated with root username =)
# 6) generate ssh key-pair if nessesary
_setup_ssh() {
  echo "[*] Generating ssh keys"
  [[ -d /home/$real_user/.ssh ]] || mkdir /home/$real_user/.ssh
  ssh-keygen -t rsa -b 4096 -f /home/$real_user/.ssh/id_rsa -N '' -C $real_user@$HOSTMANE  &>/dev/null
  chown -R $real_user:$real_user /home/$real_user/.ssh
}

[[ -f /home/$real_user/.ssh/id_rsa.pub ]] || _setup_ssh

# 9) setup zsh
_setup_zsh() {
  echo "[*] Changing shell to zsh"
  chsh -s $(which zsh) $real_user &>/dev/null
  echo "[!] You need to relogin in order to switch shell!"
}

[[ $(getent passwd $real_user | cut -d: -f7) == $(which zsh) ]] || _setup_zsh

# 10) copy wallpaper for terminal
_copy_wallpaper() {
  echo "[*] Copying terminal swallpaper"
  bg_path="https://hdwallpaperim.com/wp-content/uploads/2017/08/25/126048-Magic_The_Gathering-Elesh_Norn.jpg"
  curl -s -L $bg_path > /home/$real_user/terminal_bg.jpg
}

[[ -f /home/$real_user/terminal_bg.jpg ]] || _copy_wallpaper


# 11) setup postgresql
_setup_postgresql() {
  echo "[*] Initializin postgresql DB"
  systemctl enable postgresql
  su - postgres -c "initdb --locale en_US.UTF-8 -D '/var/lib/postgres/data'"
  systemctl start postgresql
}

systemctl status postgresql &>/dev/null || _setup_postgresql





_install_yay() {
  echo "[*] Installing yay"
  pacman -Syu --needed --noconfirm yay &>/dev/null
}

_setup_pacman() {
  echo "[*] Pacman colors setup"
  sed -ie "s|#Color|Color|" /etc/pacman.conf
}

arch_packages=(
  base-devel downgrade htop tmux zsh gnu-netcat xclip bat python2 nerd-fonts-hack
  sublime-merge deluge vivaldi atom sublime-text-4 meld
  flameshot postman-bin rbenv ruby-build postgresql android-studio nvm
  obsidian yarn vlc ventoy filezilla gimp
  nmap gobuster sqlmap crackmapexec swaks rkhunter seclists
)

_sync_packages_yay() {
  echo "[*] Syncing packages"
  cmd="yay -S --noconfirm --needed ${arch_packages[@]} &>/dev/null"
  su -c "$cmd" - $real_user
}

_cleanup_manjaro() {
  echo "[*] Cleanup Manjaro garbage"
  garbage=(
    manjaro-hello manjaro-documentation-en 
    gnome-disk-utility gnome-screenshot imagewriter lollypop pidgin 
    thunderbird transmission-gtk uget totem
  )
  pacman -Rsu "${garbage[@]}"  &>/dev/null
}

_setup_manjaro() {
  # Update system via pacman
  echo "[*] Updating system"
  pacman -Syu --noconfirm &>/dev/null
  # Install yay - AUR helper
  which yay &>/dev/null || _install_yay
  # Make pacman/yay use colors
  grep "#Color" /etc/pacman.conf &>/dev/null && _setup_pacman
  # Packages sync via yay
  _sync_packages_yay
  # Cleanup manjaro garbage
  _cleanup_manjaro
}

## SETUP PARROT
parrot_packages=(
  zsh xclip bat python2 nerd-fonts-hack
  sublime-merge deluge vivaldi sublime-text-4 meld
  flameshot postman-bin rbenv ruby-build postgresql android-studio nvm
  obsidian yarn ventoy filezilla
  crackmapexec rkhunter seclists
)

_setup_parrot() {
  # Update packages DB && sync required packages
  apt update
  apt install ${parrot_packages[@]}
}

## SETUP APPROPRIATE OS

## SETUP REST

# Setup dotfiles
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

# ruby, ruby, ruby, ruby...
_setup_ruby() {
  echo "[*] install ruby 2.7.2"
  rbenv install 2.7.2 &>/dev/null
}
which ruby || _setup_ruby

echo "[*] done!"
