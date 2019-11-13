alias zref="source ~/.zshrc"
alias zref!="source ~/.zshrc; clear"

format_time_from_timestamp() {
  date --date="@$1" +%d.%m.%y-%H:%M
}

archivate_history() {
  timestamp=$(head -n 1 $HISTFILE | grep -o -E '[0-9]{10}')
  from=$(format_time_from_timestamp $timestamp)
  to=$(date +%d.%m.%y-%H:%M)
  new_name="zsh_history_from_${from}_til_${to}.txt"
  mv $HISTFILE $new_name
  echo "Done! $from - $to history archived"
}

alias zha="archivate_history()"
