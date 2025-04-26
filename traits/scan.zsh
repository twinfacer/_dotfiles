# Some aliases for scanz
alias -g httpx="httpx-toolkit"

# Reverse DNS lookup
revdns() {
  callable pup || (echo "[!] pup not installed!" && return)
  curl https://rapiddns.io/sameip/$1#result -s | pup "tbody tr td:nth-of-type(1) text{}" | httpx | cut -d '/' -f 3 | sort -u
}

# Scan for active subdomains using _subfinder_ & _httpx_.
subz() {
  callable subfinder || (echo '[!] subfinder not installed!' && return)
  callable httpx || (echo '[!] https not installed!' && return)

  subfinder -silent -d $1 2>/dev/null | httpx -silent | cut -d '/' -f 3 | sort -u
}
