#!/usr/bin/zsh
#
# odin_up - One script to setup new odin developer machine
# Written by @twinfacer (https://github.com/twinfacer) 2023 (C)
#
#### LETS DANCE

## Utils
source_url() { source <(curl -s $1) }

source_url "https://raw.githubusercontent.com/twinfacer/_dotfiles/master/lib/output.zsh"
source_url "https://raw.githubusercontent.com/twinfacer/_dotfiles/master/traits/docker.zsh"
source_url "https://raw.githubusercontent.com/twinfacer/_dotfiles/master/traits/postgresql.zsh"

PROJECTS_DIR=${$PROJECTS_DIR:-~/projects}

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

declare -A ODIN_PROJECTS

ODIN_PROJECTS[o1]=odin.o1standard.ru
ODIN_PROJECTS[bmrdmsa]=bma.rdms.ru
ODIN_PROJECTS[rekafm]=rekafm.o-din.ru
ODIN_PROJECTS[kazanmall]=kazanmall.o-din.ru
ODIN_PROJECTS[sok]=sok.o-din.ru
ODIN_PROJECTS[oko]=oko-service.online
ODIN_PROJECTS[kp16]=kp16.o-din.ru
ODIN_PROJECTS[real-estate]=real-estate.o-din.ru
ODIN_PROJECTS[bosch]=bosch.o-din.ru
ODIN_PROJECTS[skk]=skkpodmsk.o-din.ru
ODIN_PROJECTS[crosswall]=covenant-service.o-din.ru
ODIN_PROJECTS[kvs]=kvs.o-din.ru
ODIN_PROJECTS[goldengate]=goldengate.o-din.ru
ODIN_PROJECTS[prsv]=prsv.o-din.ru
ODIN_PROJECTS[poklonkaplace]=poklonkaplace.o-din.ru
ODIN_PROJECTS[elma]=elma.o-din.ru
ODIN_PROJECTS[rusprod]=rusprod.o-din.ru
ODIN_PROJECTS[phosagro]=sp-izumrud.o-din.ru
ODIN_PROJECTS[trg]=trg.o-din.ru
ODIN_PROJECTS[raven]=raven.o-din.ru
ODIN_PROJECTS[foursquares]=foursquares.o-din.ru
ODIN_PROJECTS[redhills]=redhills.o-din.ru
ODIN_PROJECTS[cwcushwake]=cw.bck.o-din.ru
ODIN_PROJECTS[blackwood]=blackwood.o-din.ru
ODIN_PROJECTS[arcus]=arcus.o-din.ru

_check_ssh_key() {
  # We need to add ssh key to gitlab repos, do it manually
  if [ -f ~/.ssh/id_rsa.pub ]; then
    info "please add this key to gitlab https://gitlab.com/-/profile/keys"
    cat ~/.ssh/id_rsa.pub
  else
    error "please generate new SSH keys pairs and put in in ~/.ssh directory!"
    exit 0
  fi
}

_clone_or_upd() {
  local cwd=$(pwd)
  cd $PROJECTS_DIR
  local folder=$(echo "$1" | cut -d "/" -f 2)
  if [[ ! -d $folder ]]; then
    info "$folder not found - cloning"
    git clone git@gitlab.com:o-din/$1.git &>/dev/null
  else
    info "$folder found - pulling latest"
    git stash &>/dev/null
    if [[ _git_curent_branch -ne 'master' ]]; then; git checkout master &>/dev/null; fi
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
  local = pwd
  for project in $ODIN_PROJECTS; do
    info "Processing - $project"
    _clone_or_upd $project
    cd $PROJECTS_DIR/$project
    step "bundle && yarn"
    bundle &>/dev/null
    yarnpkg &>/dev/null
    if [[ ! -f ./.env ]]; then
      info ".env not found - copying example one"
      cp ./.env.example ./.env
    else
      ok ".env already exist"
    fi
    step "rails db"
    rails db:create &>/dev/null
    ssh -q -o BatchMode=yes -o StrictHostKeyChecking=no -o ConnectTimeout=5 $project 'exit 0'
    if [ $? = 0 ]; then
      ok "SSH connection already configured"
      step "dumping"
      ddb! $project
    else
      step "SSH not configured"
      ssh-copy-id -o LogLevel=QUIET -o StrictHostKeyChecking=no $project
      step "dumping"
      ddb! $project
    fi
    step "migraiting db"
    rails db:migrate &>/dev/null
  done
  ok "done"
  cd $cwd
}

_get_stuff() {
  ssh -T git@gitlab.com || _check_ssh_key
  if [[ psql postgres -tXAc "SELECT 1 FROM pg_roles WHERE rolname='odin'" = 1 ]]; then
    info "User odin already exist"
  else
    step "Createing new posstresql user - odin"
    _create_pg_superadmin "odin"
  fi
  _get_gems
  _get_projects
}

alias odgg="_get_gems"
alias odgp="_get_projects"
alias odga="_get_stuff"