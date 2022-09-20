#!/usr/bin/zsh
#
# setup_parrot.zsh - One script for post install configuration.
# Written by @twinfacer 2021-2022 (C)

autoload -U colors && colors

### SOME UTILS

say() {
  echo "$fg[green][*]$reset_color $1"
}

ok() {
  echo "$fg[green][$(echo -e "\u2714")]$reset_color $1"
}

info() {
  echo "$fg[cyan][$(echo -e "\u27A4")]$reset_color $1"
}

warn() {
  echo "$fg[orange][!]$reset_color $1"
}

step() {
  echo "  $fg[orange][$(echo -e "\u27A4")]$reset_color $1"
}

error() {
  echo "$fg[red][!]$reset_color $1"
}

exec_silent() {
  exec "$1" &>/dev/null
}

# we need root
if ! [ $(id -u) = 0 ]; then
  error "The script need to be run as root." >&2
  exit 1
else
  ok "root detected, thanks"
fi

# save real user for later
if [ $SUDO_USER ]; then
  real_user=$SUDO_USER
  info "User - $fg[green]$real_user$reset_color"
else
  real_user=$(whoami)
fi


# TODO:
# - colorize output
# - add verbosity to output
# - add moar custiomization via ENVs

## GENERIC SETUP LINUX

# Enable passwordless sudo
MAGIC_STRING="%wheel ALL=(ALL) NOPASSWD: ALL"

_enable_passwordless_sudo() {
  say "Enabling passwordless sudo"
  getent group wheel || groupadd wheel
  echo $MAGIC_STRING >> /etc/sudoers
  usermod -G wheel $real_user
  echo $(groups) 
}

[[ $(sudo tail -n 1 /etc/sudoers) == $MAGIC_STRING ]] || _enable_passwordless_sudo
[[ $(sudo tail -n 1 /etc/sudoers) != $MAGIC_STRING ]] || ok "Passwordless sudo already enabled"

# generate ssh key-pair if nessesary
_setup_ssh() {
  say "Generating ssh keys"
  [[ -d /home/$real_user/.ssh ]] || mkdir /home/$real_user/.ssh
  ssh-keygen -t rsa -b 4096 -f /home/$real_user/.ssh/id_rsa -N '' -C $real_user@$HOSTMANE  &>/dev/null
  chown -R $real_user:$real_user /home/$real_user/.ssh
}

[[ -f /home/$real_user/.ssh/id_rsa.pub ]] || _setup_ssh
[[ ! -f /home/$real_user/.ssh/id_rsa.pub ]] || ok "SSH keys are fine"

# setup zsh
_setup_zsh() {
  say "Changing shell to zsh"
  chsh -s $(which zsh) $real_user &>/dev/null
  info "You need to relogin in order to switch shell!"
}

[[ $(getent passwd $real_user | cut -d: -f7) == $(which zsh) ]] || _setup_zsh
[[ $(getent passwd $real_user | cut -d: -f7) != $(which zsh) ]] || ok "zsh is configured"

# copy wallpaper for terminal
_copy_wallpaper() {
  say "Copying terminal swallpaper"
  bg_path="https://hdwallpaperim.com/wp-content/uploads/2017/08/25/126048-Magic_The_Gathering-Elesh_Norn.jpg"
  curl -s -L $bg_path > /home/$real_user/terminal_bg.jpg
}

[[ -f /home/$real_user/terminal_bg.jpg ]] || _copy_wallpaper
[[ ! -f /home/$real_user/terminal_bg.jpg ]] || ok "[*] wp is already copied"


# ## Setup manjaro
# _setup_postgresql() {
#   echo "[*] Initializin postgresql DB"
#   systemctl enable postgresql
#   su - postgres -c "initdb --locale en_US.UTF-8 -D '/var/lib/postgres/data'"
#   systemctl start postgresql
# }


# _enable_ntpd() {
#   echo "[*] Enabling NTP service"
#   systemctl enable ntpd  &>/dev/null
#   systemctl start ntpd  &>/dev/null
# }

# _install_yay() {
#   echo "[*] Installing yay"
#   pacman -Syu --needed --noconfirm yay &>/dev/null
# }

# _setup_pacman() {
#   echo "[*] Pacman colors setup"
#   sed -ie "s|#Color|Color|" /etc/pacman.conf
# }

# arch_packages=(
#   base-devel downgrade htop tmux zsh gnu-netcat xclip bat python2 nerd-fonts-hack
#   sublime-merge deluge vivaldi atom sublime-text-4 meld
#   flameshot postman-bin rbenv ruby-build postgresql android-studio nvm
#   obsidian yarn vlc ventoy filezilla gimp
#   nmap gobuster sqlmap crackmapexec swaks rkhunter seclists
# )

# _sync_packages_yay() {
#   echo "[*] Syncing packages"
#   cmd="yay -S --noconfirm --needed ${arch_packages[@]} &>/dev/null"
#   su -c "$cmd" - $real_user
# }

# _cleanup_manjaro() {
#   echo "[*] Cleanup Manjaro garbage"
#   garbage=(
#     manjaro-hello manjaro-documentation-en 
#     gnome-disk-utility gnome-screenshot imagewriter lollypop pidgin 
#     thunderbird transmission-gtk uget totem
#   )
#   pacman -Rsu "${garbage[@]}"  &>/dev/null
# }

# _setup_manjaro() {
#   # Enable NTP if not already enabled.
#   systemctl status ntpd &>/dev/null || _enable_ntpd
#   # Update system via pacman
#   echo "[*] Updating system"
#   pacman -Syu --noconfirm &>/dev/null
#   # Install yay - AUR helper
#   which yay &>/dev/null || _install_yay
#   # Make pacman/yay use colors
#   grep "#Color" /etc/pacman.conf &>/dev/null && _setup_pacman
#   # Packages sync via yay
#   _sync_packages_yay
#   # setup postgresql
#   systemctl status postgresql &>/dev/null || _setup_postgresql
#   # Cleanup manjaro garbage
#   _cleanup_manjaro
# }

## SETUP PARROT
parrot_packages=(
  zsh
  bat
  deluge
  meld
  flameshot
  filezilla
  yarnpkg
  rkhunter
  crackmapexec
  rbenv 
  ruby-build
  seclists
)

_setup_parrot() {
  step " apt: remove Parrot junk"
  rm -f /home/$real_user/Desktop/README.license
  step " apt: update DB"
  apt update
  step " apt: full system upgrade"
  apt upgrade -yq
  step " apt: install required packages"
  apt install -y ${parrot_packages[@]}
}

## SETUP APPROPRIATE OS
case $(uname -a) in
*parrot*)
  info "Parrot detected, configuring ..."
    _setup_parrot
  ;;
*)
  info "[*] Manjaro detected, configuring ..."
  _setup_manjaro
  ;;
esac

## SETUP REST

# Install nerd font 'Hack'
_install_hack_font() {
  say "installing Hack"
  curl -o ~/Hack.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/Hack.zip
  mkdir -p ~/.fonts
  cp HackBold.ttf ~/.fonts/HackBold.ttf
  fc-cache -fv
}

# Setup dotfiles
_setup_dotfiles() {
  say "setup .dotfiles"
  export DOTDIR=/home/$real_user/.dotfiles
  cmd="curl -L 'https://git.io/fNdqS' | zsh"
  su -c "$cmd" $real_user
}

# Update dotfiles
_update_dotfiles() {
  say "update .dotfiles"
  export DOTDIR=/home/$real_user/.dotfiles
  cmd="dref"
  su -c "dref" $real_user
}

# TODO: We may need to update dotfiles if needed.
[[ -d /home/$real_user/.dotfiles ]] || _setup_dotfiles
# [[ ! -d /home/$real_user/.dotfiles ]] || _update_dotfiles

# Create projects dir
[[ -d /home/$real_user/projects ]] || mkdir /home/$real_user/projects && chown $real_user /home/$real_user/projects
[[ ! -d /home/$real_user/projects ]] || ok "Project directory already exists."

# ruby, ruby, ruby, ruby...
_setup_ruby() {
  echo "[*] install ruby 2.7.2"
  rbenv install 2.7.2 &>/dev/null
}

which ruby || _setup_ruby

ok "[*] done!"
