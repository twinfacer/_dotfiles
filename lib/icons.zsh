## Icons
icon() {
  declare -A ICONZ

  ICONZ[check]=2714      # ✓
  ICONZ[farrow]=27A4     # ➤
  ICONZ[heart]=2764      # 💝
  ICONZ[l_prompt]=e0b0
  ICONZ[r_prompt]=e0b2
  ICONZ[ruby]=e21e       # 

  echo -e "\u$ICONZ[$1]"
}

