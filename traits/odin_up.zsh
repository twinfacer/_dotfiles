#!/usr/bin/zsh
#
# odin_up - One script to setup new odin developer machine
# Written by @twinfacer (https://github.com/twinfacer) 2022 (C)
#
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
# info "please add this key to gitlab https://gitlab.com/-/profile/keys"
# cat ~/.ssh/id_rsa.pub

# TODO: create user for pg

_clone_or_upd() {
  cd $PROJECTS_DIR
  local folder=$(echo "$1" | cut -d "/" -f 2)
  if [[ ! -d $folder ]]
  then
    info "$folder not found - cloning"
    git clone git@gitlab.com:o-din/$1.git &>/dev/null
  else
    git stash &>/dev/null
    if [[ _git_curent_branch -ne 'master' ]]; then
      git checkout master &>/dev/null
    fi
    git pull --rebase origin master &>/dev/null
    ok "$folder repo is up to date"
  fi
  cd $cwd
}

# clone gems first
_get_gems() {
 for gem in ${ODIN_GEMS[*]}; do _clone_or_upd "gems/$gem"; done
}

_get_projects() {
  for project; do
    info "$project"
    _clone_or_upd $project
    cd $PROJECTS_DIR/$project
    step "bundle && yarn"
    bundle &>/dev/null
    yarnpkg &>/dev/null
    if [[ ! -f ./.env ]]
    then
      info ".env not found - copying example one"
      cp ./.env.example ./.env
    else
      ok ".env already exist"
    fi
    step "rails db"
    rails db:create &>/dev/null
    # TODO: Pipe dump directly to psql
    ssh -q -o BatchMode=yes  -o StrictHostKeyChecking=no -o ConnectTimeout=5 $project 'exit 0'
    if [ $? = 0 ]; then
      ok "SSH connection configured"
      step "dumping"
      ddb $project > $PROJECTS_DIR/$project.sql
      step "loading dump"
      udb $project
    else
      step "SSH not configured"
      ssh-copy-id -o LogLevel=QUIET -o StrictHostKeyChecking=no $project
      step "dumping"
      ddb $project > $PROJECTS_DIR/$project.sql
      step "loading dump"
      udb $project
    fi
    step "migraiting"
    rails db:migrate &>/dev/null
  done
  ok "done"
  cd $cwd
}

alias odgg="_get_gems"
alias odgp="_get_projects"