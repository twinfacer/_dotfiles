## Aliases for archlinux

which pacman &>/dev/null || return

## pacman (pac*)

# List all installed packages.
alias pacl="pacman -Q"

# List all explicitly installed packages.
alias pacle='pacman -Qqe'

# Search for package owns a file.
alias pacs="pacman -Qo"

# Remove selected packages
alias pacr="sudo pacman -Rsu"

# Clear pacman package cache
alias pacc="sudo pacman -Scc"
