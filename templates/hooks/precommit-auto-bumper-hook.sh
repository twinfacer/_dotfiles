#!/bin/sh

current_version() {
  head -n 1 README.md | grep -E -o '[0-9]+.[0-9]+.[0-9]+'
}

next_version() {
  case $1 in
    major )
      current_version | awk -F. '{printf("%d.%d.%d\n", $1+1, 0 , 0)}' ;;
    minor )
      current_version | awk -F. '{printf("%d.%d.%d\n", $1, $2+1 , 0)}' ;;
    * )
      current_version | awk -F. '{printf("%d.%d.%d\n", $1, $2 , $3+1)}' ;;
  esac
}

bump_version() {
  local old=$(current_version)
  local next=$(next_version)
  sed -i "s|$old|$next|g" README.md
  echo "Version changed: $old -> $next"
}

bump_version
git add README.md
