#!/usr/bin/zsh
#
# odin_up - One script to setup new odin developer machine
# Written by @twinfacer (https://github.com/twinfacer) 2022 (C)
#

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

#### LETS DANCE
PROJECTS_DIR=~/projects

local cwd=$(pwd)
ODIN_GEMS=(
  o-din
  o-din-audit
  o-din-director
  o-din-ku
  o-din-parking
  o-din-pm
  o-din-ppr
  o-din-rounds
  o-din-stock
  o-din-lk
  o-din-report
)

# We need to add ssh key to gitlab repos, do it mannually
cat ~/.ssh/id_rsa.pub

# clone gems first
for gem in ${ODIN_GEMS[*]}
do
  cd $PROJECTS_DIR
  if [[ ! -d $gem ]]
  then
    info "$gem not found - cloning"
    git clone git@gitlab.com:o-din/gems/$gem.git
  else
    git stash 1>/dev/null 2>&1
    if [[ _git_curent_branch -ne 'master' ]]; then
      git checkout master 1>/dev/null 2>&1
    fi
    git pull --rebase 1>/dev/null 2>&1
    ok "$gem updated"
  fi
  cd $cwd
done