# Idea
Single command new machine setup, right from fresh distro.
```bash
$ some_magic | sh
=> You have stuff! Enjoy =)
[Cool ZSH prompt]>
```
Enter __setup.sh__.

== setup.sh

-> Installs packages

-> Configures them

-> Configures OS

[-> Do shell custom scripts]

.strain.ini #???
[install]
atom
docker
dockbarx
firefox
meld
tmux
xfce4-dockbarx-plugin
yarn
zsh
zsh-autosuggestions
zsh-syntax-highlight
[install:git]
twinfacer/_dotfiles
[configure:xfce4-panel]
cp ~/_custom/cfg/panel /etc/xfce4/panel/default/config/
[shell:dotfiles]
git clone https://github.com/twinfacer/_dotfiles
cd _dotfiles
./setup.zsh
[shell:rvm]
