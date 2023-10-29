which pacman &>/dev/null || return

# pacman (pac*)
alias pacl="pacman -Q"
alias pacl!="pacman -Qe"
alias pacle='pacman -Qent'
alias pacs="pacman -Qo"
alias pacr="sudo pacman -Rsu"
alias pacru="pacman -Qtdq | pacman -Rns -"
