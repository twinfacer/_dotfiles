# ssh aliases

# Generate ssh key-pair
alias ssg="ssh-keygen -t rsa -b 4096"

# Copy ssh pubkey to clipboard
alias ssc="cat ~/.ssh/id_rsa.pub | clipcopy; echo \"[*] Copied!\" "

# Alias for ssh-copy-id
alias sscp="ssh-copy-id"
