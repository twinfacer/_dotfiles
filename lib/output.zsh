#### Messaging
autoload -U colors && colors

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