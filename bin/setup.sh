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

# = Prepare

# 1) enable NTP
_enable_ntpd() {
  echo "[*] enable FTP"
  systemctl enable ntpd
  systemctl start ntpd
}

systemctl status ntpd &>/dev/null || _enable_ntpd

# 2) install yay
_install_yay() {
  echo "[*] installing yay"
  pacman -Syu --needed yay git base-devel
}

which yay &>/dev/null || _install_yay

# 3) passwordless sudo
magic_string="%wheel ALL=(ALL) NOPASSWD: ALL"

_enable_passwordless_sudo() {
  echo "[*] enable passwordless sudo"
  echo $magic_string >> /etc/sudoers
  usermod -G wheel $real_user
}

tail -n 1 /etc/sudoers | grep $magic_string &>/dev/null || _enable_passwordless_sudo

# 4) make pacman/yay use colors
_setup_pacman() {
  echo "[*] pacman colors setup"
  sed -ie "s|#Color|Color|" /etc/pacman.conf
}

grep "#Color" /etc/pacman.conf &>/dev/null && _setup_pacman

# 5) packages sync via yay
packages=(
  firefox atom tmux zsh sublime-merge sublime-text-3 meld flameshot postman-bin rbenv ruby-build postgresql
  xfce4-dockbarx-plugin dockbarx obsidian xclip yarn python2 nerd-fonts-source-code-pro
)

_sync_packages() {
  echo "[*] syncing packages"
  cmd="yay -S --noconfirm --needed ${packages[@]}"
  echo $real_user
  echo $cmd
  su -c "$cmd" $real_user
}

# _sync_packages

# setup zsh
_setup_zsh() {
  current_shell=$(awk -F: "/$real_user/ { print $7}" /etc/passwd)
  echo $current_shell
  [ $current_shell = $(which zsh) ] || echo "[*] change shell to zsh" && chsh -s $(which zsh) $real_user &>/dev/null

  touch /home/$real_user/.zshrc
}

# copy wallpaper for terminal
curl -s -L https://hdwallpaperim.com/wp-content/uploads/2017/08/25/126048-Magic_The_Gathering-Elesh_Norn.jpg > /home/$real_user/terminal_bg.jpg

# setup ssh
_setup_ssh() {
  echo "[*] generating ssh keys"
  mkdir /home/$real_user/.ssh
  ssh-keygen -t rsa -b 4096 -f /home/$real_user/.ssh/id_rsa -N ''
  chown -R $real_user:$real_user /home/$real_user/.ssh
}

[[ -f /home/$real_user/.ssh/id_rsa.pub ]] || _setup_ssh

# setup postgresql
_setup_postgresql() {
  systemctl enable postgresql
  su - postgres -c "initdb --locale en_US.UTF-8 -D '/var/lib/postgres/data'"
  systemctl start postgresql
}

systemctl status postgresql &>/dev/null || _setup_postgresql

# setup dotfiles
_setup_dotfiles() {
  echo "[*] setup .dotfiles"
  export DOTDIR=/home/$real_user/.dotfiles
  curl -L 'https://git.io/fNdqS' | zsh
}

[[ -d /home/$real_user/.dotfiles ]] || _setup_dotfiles

# projects dir
[[ -d /home/$real_user/projects ]] || mkdir /home/$real_user/projects && chown $real_user /home/$real_user/projects


# TODO: ru layout
# setxkbmap -layout us,ru

echo "[*] done!"
