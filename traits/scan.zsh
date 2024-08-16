revdns() {
  curl https://rapiddns.io/sameip/$1#result -s | pup "tbody tr td:nth-of-type(1) text{}" 
}
