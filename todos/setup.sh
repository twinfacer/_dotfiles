#!/usr/bin/sh
# setup.sh - Postinstall utility wizard.
# --init - Create empty config.
# -c=, --config= - Path to config file.
# -f, --force - Enforce config applying, even if config's SHA1 hashes are equal.

# 1) Find config. if none found - warn user and exit.
# 2) Read & parse config. warn user & exit if any errors happens.
# 3) Apply config. Compute sha1 hash of config. Save it to somewhere.


setup -c https://github.com/twinfacer/_dotfiles/raw/master/templates/archlinux
# ==> setup.sh v 1.13.1 (Update available! v 1.14.3)
# ==> Config: External Source -> Fetching ... Done
# ==>
# ==> Config: Parsing ... Done
# ==> Config: Applying
# ==> [install:toolz] - Done.
# ==> [custom:_dotfiles] - Done.
# ==> [custom:xfce4-panel] - Done.

# archlinux
# [install:toolz]
# atom
# curl
# tmux
# zsh
# [custom:_dotfiles]
# curl -L "https://git.io/fNdqS" | sh
# [custom:xfce4-panel]
# curl -s https://github.com/twinfacer/_dotfiles/raw/master/templates/xfce-panel.conf --output ~/configs/.xfce4-panel.conf
