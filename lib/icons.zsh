## Icons (REQUIRE NERD FONT TO PROPERLY WORK!!!)
icon() {
  declare -A ICONZ

  ICONZ[check]=2714        # ✓
  ICONZ[farrow]=27A4       # ➤
  ICONZ[heart]=2764        # 💝
  ICONZ[l_prompt]=e0b0     # 
  ICONZ[r_prompt]=e0b2     #
  ICONZ[ruby]=e21e         #
  ICONZ[status]=fcb5       #
  ICONZ[git_branch]=e725   #
  ICONZ[git_feature]=e726  #
  ICONZ[bug]=f188          #
  ICONZ[js_icon]=f898      #

  echo -e "\u$ICONZ[$1]"
}

