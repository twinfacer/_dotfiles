## Icons
declare -A ICONZ

ICONZ[check]=2714   # ✓
ICONZ[farrow]=27A4  # ➤
ICONZ[heart]=2764   # 💝

icon() {
  echo -e "\u$ICONZ[$1]"
}

all_icons() {
    # for
}