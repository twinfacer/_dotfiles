#!/usr/bin/zsh
#
# setup_parrot.zsh - One script for post install configuration.
# Written by @twinfacer (https://github.com/twinfacer) 2021-2022 (C)

# Output verbosity: [SILENT|NORMAL*|VERBOSE|DEBUG]

_help() {
  echo <<EOF
    -h, --help - Display this help message.
    ## Output Controls
      -s, --silence - Suppress all noncritical output.
      -v, --verbose - Increases output verbosity.
      -vv, --debug - Outputs everything it does, for debug purposes.
EOF
}


### SOME UTILS
#### source url
# source_url() {
#   curl -s -L $1 | 
# }

# source_url "https://raw.githubusercontent.com/twinfacer/_dotfiles/master/bin/test.zsh"

# funny



autoload -U colors && colors

#### Icons
declare -A ICONZ

ICONZ[check]=2714   # ✓
ICONZ[farrow]=27A4  # ➤
ICONZ[heart]=2764   # 💝

icon() {
  echo -e "\u$ICONZ[$1]"
}

#### Messaging
say() {
  echo "$fg[green][*]$reset_color $1"
}

ok() {
  echo "$fg[green][$(icon check)]$reset_color $1"
}

info() {
  echo "$fg[cyan][$(icon farrow)]$reset_color $1"
}

warn() {
  echo "$fg[orange][!]$reset_color $1"
}

step() {
  echo "  $fg[cyan][$(icon farrow)]$reset_color $1"
}

error() {
  echo "$fg[red][!]$reset_color $1"
}

#### Generic helpers
exec_silent() {
  eval "$1" &>/dev/null
}

# TODO: IMPLEMENT ME
exec_or_ok() {
  eval $1 || ok $2
}

#### Some preparations and checks

# we need root
if ! [ $(id -u) = 0 ]; then
  error "The script need to be run as root." >&2
  exit 1
else
  ok "$fg[red]root$reset_color detected, thanks =)"
fi

# save real user for later
if [ $SUDO_USER ]; then
  real_user=$SUDO_USER
  info "User - $fg[green]$real_user$reset_color"
else
  real_user=$(whoami)
fi


# TODO:
# - add argparse
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
  warn "You need to relogin in order to switch shell!"
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
[[ ! -f /home/$real_user/terminal_bg.jpg ]] || ok "Terminal wallpaper is already copied"


# ## Setup manjaro
_setup_postgresql() {
  echo "[*] Initializin postgresql DB"
  systemctl enable postgresql
  su - postgres -c "initdb --locale en_US.UTF-8 -D '/var/lib/postgres/data'"
  systemctl start postgresql
}


_enable_ntpd() {
  echo "[*] Enabling NTP service"
  systemctl enable ntpd  &>/dev/null
  systemctl start ntpd  &>/dev/null
}

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
  # Enable NTP if not already enabled.
  systemctl status ntpd &>/dev/null || _enable_ntpd
  # Update system via pacman
  echo "[*] Updating system"
  pacman -Syu --noconfirm &>/dev/null
  # Install yay - AUR helper
  which yay &>/dev/null || _install_yay
  # Make pacman/yay use colors
  grep "#Color" /etc/pacman.conf &>/dev/null && _setup_pacman
  # Packages sync via yay
  _sync_packages_yay
  # setup postgresql
  systemctl status postgresql &>/dev/null || _setup_postgresql
  # Cleanup manjaro garbage
  _cleanup_manjaro
}

## SETUP PARROT
_add_sublime_repos() {
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg &>/dev/null
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list &>/dev/null
}

parrot_packages=(
  zsh
  bat
  deluge
  meld
  flameshot
  filezilla
  yarnpkg
  rkhunter
  rbenv 
  ruby-build
  seclists
  sublime-text
  sublime-merge
  apt-transport-https
  # crackmapexec
)

_setup_parrot() {
  step "remove Parrot junk"
  rm -f /home/$real_user/Desktop/README.license
  step "apt-get: update DB"
  exec_silent "apt update"
  step "apt: full system upgrade"
  exec_silent "apt upgrade -y"
  step "apt: install required packages"
  exec_silent "apt install -y ${parrot_packages[@]}"
  _add_sublime_repos
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
  mkdir -p /home/$real_user/.fonts
  cd /home/$real_user/.fonts
  wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/Hack.zip
  unzip -qq -f Hack.zip
  fc-cache -fv &>/dev/null
}

su -c "fc-list" $real_user | grep "Hack" &>/dev/null || _install_hack_font
su -c "fc-list" $real_user | grep "Hack" &>/dev/null && ok "Hack font is already installed"

# Setup dotfiles
_setup_dotfiles() {
  say "installing .dotfiles"
  export DOTDIR=/home/$real_user/.dotfiles
  cmd="curl -L 'https://git.io/fNdqS' | zsh"
  su -c "$cmd" $real_user
}

# TODO: git stash, git checkout master
# Update dotfiles
_update_dotfiles() {
  say "updating .dotfiles"
  # su -c "dref" $real_user
}

[[ -d /home/$real_user/.dotfiles ]] || _setup_dotfiles
[[ ! -d /home/$real_user/.dotfiles ]] || _update_dotfiles

# Create projects dir
[[ -d /home/$real_user/projects ]] || mkdir /home/$real_user/projects && chown $real_user /home/$real_user/projects
[[ ! -d /home/$real_user/projects ]] || ok "Project directory already exists."

# ruby-build because system is old as shit
_setup_ruby-build() {
  say "installing ruby-build"
  cd /home/$real_user/projects
  git clone https://github.com/rbenv/ruby-build.git
  PREFIX=/usr/local ./ruby-build/install.sh
}

which ruby-build &>/dev/null || _setup_ruby-build
which ruby-build &>/dev/null && ok "ruby build is installed"

# ruby, ruby, ruby, ruby...
_setup_ruby() {
  echo "[*] install ruby 2.7.2"
  rbenv install 2.7.2
}

rbenv versions | grep "#Color" &>/dev/null && _setup_ruby
rbenv versions | grep "#Color" &>/dev/null || ok "ruby 2.7.2 is already installed"

echo "$fg[green][🐱]$reset_color done!"