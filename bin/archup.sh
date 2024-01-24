#!/bin/zsh
#
# setup.sh - One script for post install configuration.
# Written by @twinfacer (https://github.com/twinfacer) 2021-2023 (C)

VER="3.2"

_help() {
  cat << EOF
  setup.sh v$VER by @twinfacer
  # Opts
  ## Generic
    -h, --help - Display this help message.
EOF
}

_banner() {
  which figlet &>/dev/null && figlet setup.sh
  which figlet &>/dev/null || echo "setup.sh"
  echo "v$VER\n"
}

_banner

if [[ $1 == '-h' ]]; then; _help && exit 0 ; fi

### SOME UTILS
source_url() { source <(curl -s $1) }

source_url "https://raw.githubusercontent.com/twinfacer/_dotfiles/master/lib/icons.zsh"
source_url "https://raw.githubusercontent.com/twinfacer/_dotfiles/master/lib/output.zsh"

### SETUP
# we need root
if ! [ $(id -u) = 0 ]; then
  error "The script need to be run as root." >&2
  exit 1
else
  ok "$fg[red]root$reset_color detected, thanks =)"
fi

# save real user for later
if [ $SUDO_USER ]; then
  REAL_USER=$SUDO_USER
  info "User - $fg[green]$REAL_USER$reset_color"
else
  REAL_USER=$(whoami)
fi

# damn OS X
if [[ "$OSTYPE" = Darwin* ]]; then
  IS_OSX=1
  HOME_DIR=/Users/$REAL_USER
else
  IS_OSX=0
  HOME_DIR=/home/$REAL_USER
fi

## 1) Enable passwordless sudo
MAGIC_STRING="%wheel ALL=(ALL) NOPASSWD: ALL"

_enable_passwordless_sudo() {
  say "Enabling passwordless sudo"
  getent group wheel || groupadd wheel
  echo $MAGIC_STRING >> /etc/sudoers
  usermod -G wheel $REAL_USER &>/dev/null
}

[[ $(sudo tail -n 1 /etc/sudoers) != $MAGIC_STRING ]] || ok "Passwordless sudo already enabled"
[[ $(sudo tail -n 1 /etc/sudoers) == $MAGIC_STRING ]] || _enable_passwordless_sudo

## 2) Generate ssh key-pair if nessesary
_setup_ssh() {
  say "Generating ssh keys"
  [[ -d $HOME_DIR/.ssh ]] || mkdir $HOME_DIR/.ssh
  ssh-keygen -t rsa -b 4096 -f $HOME_DIR/.ssh/id_rsa -N '' -C $REAL_USER@$HOST  &>/dev/null
  chown -R $REAL_USER:$REAL_USER $HOME_DIR/.ssh
}

[[ ! -f $HOME_DIR/.ssh/id_rsa.pub ]] || ok "SSH keys are fine"
[[ -f $HOME_DIR/.ssh/id_rsa.pub ]] || _setup_ssh

# 3) Switch default shell to zsh
_setup_zsh() {
  say "Changing shell to zsh"
  chsh -s $(which zsh) $REAL_USER &>/dev/null
  warn "You need to relogin in order to switch shell!"
}

# TODO: Make it works with MACOS
if [[ IS_OSX != 1 ]]; then
  [[ $(getent passwd $REAL_USER | cut -d: -f7) != $(which zsh) ]] || ok "zsh is set as default shell"
  [[ $(getent passwd $REAL_USER | cut -d: -f7) == $(which zsh) ]] || _setup_zsh
fi

## 4) Setup specific distros

### 4.1) archlinux - Enable NTP
_enable_ntpd() {
  step "Enabling NTP service"
  systemctl enable ntpd  &>/dev/null
  systemctl start ntpd  &>/dev/null
}

### 4.2) archlinux - Install yay
_install_yay() {
  step "Installing yay"
  su -c "git clone https://aur.archlinux.org/yay.git &>/dev/null" - $REAL_USER
  su -c "cd yay; makepkg -si --noconfirm &>/dev/null" - $REAL_USER
  rm -rf yay
}

### 5.3) archlinux - setup pacman/yay colors
_setup_pacman() {
  step "Pacman colors setup"
  sed -ie "s|#Color|Color|" /etc/pacman.conf
}

### 5.4) archlinux - install nessecary packages
arch_packages=(
  # Core stuff
  man-db downgrade xfce4-docklike-plugin libyaml libyaml-devel
  # Terminal stuff
  tmux zsh zsh-autosuggestions xclip figlet jq fzf asciinema ttf-hack-nerd
  # Network stuff
  gnu-netcat mtr swaks smbclient nfs-utils
  # Base software
  deluge deluge-gtk vivaldi gimp libreoffice-still flameshot vlc bleachbit
  # Development
  obsidian sublime-merge meld postman-bin vscodium docker
  rbenv ruby-build postgresql android-studio nvm yarn
)

_sync_packages() {
  cmd="yay -S --noconfirm --needed ${arch_packages[@]} &>/dev/null"
  su -c "$cmd" - $REAL_USER
}

### 5.5) archlinux - cleanup usused apps
_cleanup_arch() {
  garbage=(
    # mousepad
    parole xfce4-appfinder xfce4-artwork xfce4-battery-plugin xfce4-cpufreq-plugin
    xfce4-cpugraph-plugin xfce4-dict xfce4-diskperf-plugin xfce4-eyes-plugin
    xfce4-genmon-plugin xfce4-mailwatch-plugin xfce4-mount-plugin xfce4-mpc-plugin
    xfce4-netload-plugin xfce4-pulseaudio-plugin xfce4-screenshooter
    xfce4-sensors-plugin xfce4-smartbookmark-plugin xfce4-systemload-plugin
    xfce4-time-out-plugin xfce4-timer-plugin xfce4-verve-plugin
    xfce4-wavelan-plugin xfce4-weather-plugin
  )
  pacman -Rsu --noconfirm "${garbage[@]}" &>/dev/null
}

_setup_arch() {
  #step "Checking NTP"
  #systemctl status ntpd &>/dev/null || _enable_ntpd
  step "Updating system"
  pacman -Syu --noconfirm &>/dev/null
  step "Setup yay"
  which yay &>/dev/null || _install_yay
  step "Enabling pacman/yay colors"
  grep "#Color" /etc/pacman.conf &>/dev/null && _setup_pacman
  step "Cleanup unused packages"
  _cleanup_arch
  step "Install required packages"
  _sync_packages
}

_setup_arch

## SETUP REST
systemctl status postgresql &>/dev/null && ok "postgresql already initialized"
systemctl status postgresql &>/dev/null || _setup_postgresql

### Setup Postgres
_setup_postgresql() {
  say "Initializing postgresql DB"
  systemctl enable postgresql &>/dev/null
  su - postgres -c "initdb --locale en_US.UTF-8 -D '/var/lib/postgres/data' &>/dev/null"
  systemctl start postgresql
}

### Setup dotfiles
_setup_dotfiles() {
  say "installing .dotfiles"
  export DOTDIR=$HOME_DIR/.dotfiles
  su -c "curl -L 'https://git.io/fNdqS' | zsh" - $REAL_USER
}

_update_dotfiles() {
  say "updating .dotfiles"
  cd $DOTDIR
  git stash save -u &>/dev/null
  git checkout master &>/dev/null
  git pull --rebase origin master &>/dev/null
}

[[ ! -d $HOME_DIR/.dotfiles ]] || _update_dotfiles
[[ -d $HOME_DIR/.dotfiles ]] || _setup_dotfiles

### Projects folder
_create_projects_folder() {
  say "Creating ~/projects folder"
  su -c "mkdir $HOME_DIR/projects" - $REAL_USER
}

[[ -d $HOME_DIR/projects ]] && ok "Project directory already exists."
[[ ! -d $HOME_DIR/projects ]] &&  _create_projects_folder

### Install vscodium packages
VSCODIUM_PACKAGES=(
  hediet.vscode-drawio
  mrmlnc.vscode-duplicate
  eamodio.gitlens
  bierner.markdown-preview-github-styles
  rebornix.ruby
  castwide.solargraph
  pflannery.vscode-versionlens
  octref.vetur
  wingrunr21.vscode-ruby
)

_setup_vscodium() {
  say "Installing vscodium packages"
  for ext in "${VSCODIUM_PACKAGES[@]}"; do;
    su -c "codium --install-extension $ext &>/dev/null" - $REAL_USER;
  done
}

which codium &>/dev/null && _setup_vscodium

## TODO: Do we still need this?
# ruby-build because system is old as shit
_setup_ruby-build() {
  say "Installing ruby-build"
  cd $HOME_DIR/projects
  git clone https://github.com/rbenv/ruby-build.git
  PREFIX=/usr/local ./ruby-build/install.sh
  rm -rf ruby-build
}

which ruby-build &>/dev/null || _setup_ruby-build
which ruby-build &>/dev/null && ok "ruby-build is already installed"

# ruby, ruby, ruby, ruby...
_setup_ruby_320() {
  say "Installing ruby 3.2.0"
  su -c "rbenv install 3.2.0" - $REAL_USER
  su -c "rbenv global 3.2.0" - $REAL_USER
}

_setup_node() {
  say "Installing nvm && lts/fermium node"
  su -c "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash &>/dev/null" - $REAL_USER
  export NVM_DIR="$HOME_DIR/.nvm"
  su -c "[ -s $NVM_DIR/nvm.sh ] && \. $NVM_DIR/nvm.sh; nvm install lts/fermium &>/dev/null" - $REAL_USER
  [ -s $NVM_DIR/nvm.sh ] && \. $NVM_DIR/nvm.sh
}

[[ -d $HOME_DIR/.nvm ]] &>/dev/null && ok "nvm already installed"
[[ ! -d $HOME_DIR/.nvm ]] &>/dev/null && _setup_node

[[ -d $HOME_DIR/.rbenv/versions/3.2.0 ]] && ok "ruby 3.2.0 is already installed"
[[ ! -d $HOME_DIR/.rbenv/versions/3.2.0 ]] && _setup_ruby_320

ok "done!"
