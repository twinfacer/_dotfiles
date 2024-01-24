callable ssh || return

alias ssg="ssh-keygen -t rsa -b 4096"
alias ssc="cat ~/.ssh/id_rsa.pub | clipcopy; echo \"[*] Copied!\" "
alias sscp="ssh-copy-id"
