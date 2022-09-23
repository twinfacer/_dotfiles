alias _="sudo"
alias yolo="sudo"
alias p="echo"
alias h="man"
alias m="mount"

alias ...="cd ../.."
alias ....="cd ../../.."

alias -g L="less"
alias -g G="| grep"
alias -g wget='wget --no-hsts'

alias ll="ls -lAhF"

alias ed="${EDITOR}"
alias ved="${VISUAL}"
alias wh="which"

alias wcl="wc -l"
alias duh="du -h"
alias duhs="du -sh"

alias nuke="rm -rf"

alias sa="alias | grep"
alias sys="inxi -Fazy"

# Small shortcut for creating and cd'ing into <TARGET_DIR>
take() {
  mkdir -p $1 && cd $1
}

# Check binary existence
callable() {
  which $1 &>/dev/null
}

# peek - Smart file system lookup utility.
# usage: peek /etc/docker
peek() {
  if [[ -d $1 || -z $1 ]]; then
    ls -lAhF ${1:-$(pwd)}
  else
    if [[ $(cat $1 | wc -l) -gt 80 ]]; then
      cat $1 | less
    else
      cat $1
    fi
  fi
}

# ex - Universal archive extractor utility.
# usage: ex <archive_file>
ex() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# serve - small ruby-powered HTTP SERVER.
# Usage: serve [port:8000]
serve() {
  callable ruby || (echo "No ruby found - no fun for ya" && exit 0)
  ruby -run -e httpd . -p ${1:-8000}
}
