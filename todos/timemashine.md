# warp
__warp__ - [warp directory](https://github.com/mfaerevaag/wd) on steroids (support remote clients as well, automatic key management via ssh-copy-id). Observe!
``` shell
~:> warp pro
~/projects/:> cd vip_client_app
~/projects/vip_client_app/:> warp add vip
=> warp point added: '~/projects/vip_client_app' as 'vip'
~/projects/vip_client_app/:> cd ~
~:> warp @client1
=> [!] warp point '@client' unknown! Provide it's SSH address in format user@host[:port=22]
tech@app.vip-client.my_company.com:3022
=> warp point added:'tech@app.vip-client.my_company.com:3022' as '@client1'
=> [!] No key authentication detected, please provide password for 'tech' user:
****************
=> Accepted! default keyfile (~/.ssh/id_rsa.pub) installed!
tech@~> exit
~:> warp vip
~/projects/vip_client_app/:>
```
# abathur

# setup.sh
setup.sh - one command to fully setup new machine. Observe!
``` shell
setup github:twinfacer@_dotfiles/templates/setup.manjaro.sh
=> Welcome to setup.sh - one line new mashine configuration.
=> Configuration: [Github] - https://github.com/twinfacer/_dotfiles/templates/setup.manjaro.sh
=> Applying configuration:
=> [Shell:install_yay]
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
=> [Install:yay]: zsh tmux dockbarx xfce4-dockbarx-plugin atom meld gitter
=> Installing via 'yay': Done.
=> [Shell:dotfiles]: ... | sh
```
