## \_dotflies
~~Magical~~ Basic dotfiles for linuz && zsh.

![Preview](https://github.com/twinfacer/_dotfiles/raw/master/preview.png)

### System requirements:
For now only tested on archlinux/manjaro, cygwin and termux shells.
Required packages:
- [git](https://git-scm.com/)
- [zsh](http://zsh.sourceforge.net/)
- [tmux](https://github.com/tmux/tmux)
- [nerd fonts](https://github.com/ryanoasis/nerd-fonts)

### Installation:
via curl
```shell
curl -L "https://git.io/fNdqS" | zsh
```

### Usage:
Start terminal -> __tsr__ (aka restore (create/attach) tmux default session) -> You are ready!

ssh to remote host -> __tsr__ -> You are remotely ready (WIP and wanky but helpfull)!

This tools setup works almost perfectly for me as daily terminal ~~ab~~user, git nerd and js/ruby (mostly, but not limited to) fullstack web developer. Feel free to add your own zsh scripts, just put whem into ~/.dotfiles/local/ dir. Useful for per mashine configuration (env variables, credentials, hardware hacks, etc ...).

### Features:
  - __zsh__ is shell of choice. 
  - __tmux__ is multiplexor of choice. Mouse is on by default but __tmux__ is configured to be mousless as possible.
  - Easy navigation via __AUTO_CD__ zsh option && integrated [__wd__](https://github.com/mfaerevaag/wd). Wow, so much speed!
  - Alias all the things! (Over ~120 aliases for linux, git and other tools, see [this](#aliases) for full reference)
  - Colorize all the things! Most usual terminal stuff (grep/ls/git/etc...) is colorized by default.
  - Mouse is aweful, so keybind as much as possible (see [this](#keybindings) for full reference).
  - Abuse __zsh__ autocomplete as much as possible. Wow, so less typing, so much fun stuff (I mean, eh, productivity)!

### Keybindings:
#### ZSH
zsh uses __emacs__ keybindings by default with addition of following:
- [Ctrl+Left/Right Arrow] - Move backward/forward by word.
- [Home/End] - Move to beginning/end of line.
- [Ctrl+W] - Delete word backward.
- [ESC+W] - Delete from cursor backward
- [ESC+Q] - Cut line and insert it as next command.
- [ESC+R] - Reload zsh config.
- [Up/Down] - Search history backward/forward.

#### tmux
__tmux__ is configured to enter copy mode by mouse scrolling.
- [Ctrl+B] - Send prefix.
- [Shift+Down] - New window with current path.
- [Shift+Left/Right] - Select previous/next window.
- [Prefix, 1-9] - Select 1-9 window.
- [Ctrl+Shift+Left/Right] - Move current window back/forward.
- [Alt+Direction] - Select pane in direction.
- [Prefix, |] - Split panes horizontaly (with current path).
- [Prefix, -] - Split panes verticaly (with current path).

### Aliases
_*_ means global.
Generic linux stuff:
- [...] - Cd 2 dirs back.
- [....] - Cd 3 dirs back.
- [G]* - __grep__
- [L]* - __less__
- [_, yolo] - __sudo__.
Ruby stuff:
 - [b] - __bundle__
 - [cov] - Show coverage [simplecov gem](https://github.com/colszowka/simplecov)
dref='_refresh_dotfiles()'
duh='du -h'
duhs='du -sh'
ed=nano
Git stuff:
ga='git add'
gaa='git add .; git status -s'
gae='git add -e'
gb='git --no-pager branch'
gbc='git branch -c'
'gbc!'='git branch -C'
gbl='gb -l'
gbm='git branch -m'
'gbm!'='git branch -M'
gbr='git branch -d'
'gbr!'='git branch -D'
gbum='git branch --no-merged=master'
gc='git checkout'
gcb='git checkout -b'
gcf=_git_checkout_feature
gcl='git clone'
gcm='git commit -m'
gcma='git commit -am'
gcmt='git checkout master'
gcp='git cherry-pick'
gct='git checkout --track'
gd='git diff --color'
gdc='git diff --color --cached HEAD'
gf='git fetch'
gfix='git add . ; git commit --amend'
glog='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
gpush='git push origin $(git_current_branch)'
'gpush!'='git push -f origin $(git_current_branch)'
grb='git rebase'
grba='git rebase --abort'
grbc='git rebase --continue'
grbi='git rebase -i'
grbs='git rebase --skip'
gref='git pull -r origin master'
grep='grep --color=auto'
grl='git reflog'
grm='git remote'
grma='git remote add'
grmd='git remote remove'
grmr='git remote rename'
grmu='git remote get-url'
'grmu!'='git remote set-url'
grmv='git remote -v'
grt='git reset'
'grt!'='git reset --hard'
gsa='git stash apply'
gsd='git stash drop'
gsh='git show'
gsl='git stash list'
gss='git stash save -u'
gst='git status -s'
gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'
h=man
h1='HEAD~1'
hd=HEAD
history=history_wrapper
hype='sl | lolcat'
ll='ls -lAhF'
lll='ls -lAhF | lolcat'
lol=lolcat
ls='ls --color=tty'
m=mount
mt=master
neo=cmatrix
nuke='rm -rf'
p=echo
pacl='pacman -Q'
pacr='sudo pacman -R'
pacu='sudo pacman -Suyy'
prconf='ved ~/.pryrc'
prh='ved ~/.pry_history'
r=rvm
rc='rails console'
'rd!'='rvm remove'
rdm='rails db:migrate'
rgi='gem install'
rgl='gem list'
rgm='rails generate migration'
ri='rvm install'
rl='rvm list'
rlk='rvm list known'
rr='rails routes'
'rr!'='rvm reinstall'
rs='rails server'
ru='rvm use'
'ru!'='rvm use --default'
run-help=man
rvm-restart='rvm_reload_flag=1 source '\''/home/twinfacer/.rvm/scripts/rvm'\'
sc='sudo systemctl'
scdn='sudo systemctl stop'
'scdn!'='sudo systemctl disable'
scr='sudo systemctl restart'
scs='sudo systemctl status'
scup='sudo systemctl start'
'scup!'='sudo systemctl enable'
Tmux Stuff: 
- [tconf] - __ed ~/.tmux.conf__ (open tux config file in editor)
tdc='tmux detach-client'
tlc='tmux list-clients'
tref='tmux source-file ~/.tmux.conf'
tsa='tmux attach-session -t'
tsc='tmux new-session -s'
tsk='tmux kill-session -t'
tsl='tmux list-sessions'
tsr=restore
ved=atom
wcl='wc -l'
wh=which
WD stuff:
- [wp] - __wd__ (aka warp directory)
- [wpa] - wd add <name> (add current dir as waypoint named <name>)
- [wpl] - wd list (lists all known waypoints)
- [wpr] - __wd rm__ <name> (remove waypoint named <name>)
 JS stuff:
- [ya] - __yarn__.
- [yaa]  - __yarn add__
- [zref] - source ~/.zshrc
- [zref!] - source ~/.zshrc; clear

