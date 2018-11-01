# Colorizes foreground text color
pp() {
  print -Pn "%F{$2}$1%f"
}

# Colorizes background text color
ppb() {
  print -Pn "%K{$2}$1%k"
}

# Colorizes both foreground and background
colorize() {
  echo -n "%K{$2}%F{${3}}$1%f%k"
}


# Prints colors map
lscolors() {
  for row in {0..15}; do
    for col in {0..15}; do; pp "${1:-$(( $row * 16 + $col ))} " $(( $row * 16 + $col )); done
    echo
  done
  # for fg in {16..255}; do; pp "${1:-$fg} " $fg; done
}
