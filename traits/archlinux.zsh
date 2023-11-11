## Aliases for archlinux

which pacman &>/dev/null || return

## pacman (pac*)
# List all installed packages.
alias pacl="pacman -Q"
# List all explicitly installed packages.
alias pacl!='pacman -Qent'
# Search for package owns a file.
alias pacs="pacman -Qo"
# Remove selected packages
alias pacr="sudo pacman -Rsu"
