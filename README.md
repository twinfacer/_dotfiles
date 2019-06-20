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
__zsh__ uses _emacs_ keybindings by default with addition of following:
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
_*_ means _global_.

#### Generic Linux stuff:
- [...] - Cd 2 dirs back.
- [....] - Cd 3 dirs back.
- [G]* - __grep__.
- [L]* - __less__.
- [_, yolo] - __sudo__. (Just do it!)
- [duh] - __du -h__ (Disc usage, huminized).
- [duhs] - __du -sh__ (Disc usage, hummanized, summarize).
- [ed] - __nano__ (when you too young for vim, simple but powerfull).
- [ved] - __atom__ (stands for VISUAL EDITOR, stuff with GUI).
- [h] - __man__ (RTFM && TLDR).
- [wcl] - __wc -l__ (How many sweel aliases I have __alias | wcl__).
- [ll] __ls -lAhF__ (ls all as list for humans).
- [m] - __mount__ ( Mount 'em!).
- [nuke] - __rm -rf__( :city_sunrise: ).
- [p] - __echo__ (because __ruby__).
- [wh] - __which__ (WTF is that???).

#### Ruby/Rails stuff:
- [b] - __bundle(r)__.
- [cov] - Show coverage in browser [simplecov gem](https://github.com/colszowka/simplecov).
- [r] - __rvm__. (Because one ruby just isn't enought!)
- [ri] - __rvm install__.
- [rl] - __rvm list__.
- [rlk] - __rvm list known__
- [rr!!] - __rvm reinstall__. (Damn OpenSSl!)
- [rd!]  - __rvm remove__.
- [ru] - __rvm use__.
- [ru!] - __rvm use --default__.
- [rs] - __rails server__.
- [rc]  - __rails console__.
- [rr] - __rails routes__.
- [rdm] - __rails db:migrate__. (Keep your DB up to date)
- [rgm] - __rails generate migration__.
- [rgi] - __gem install__.
- [rgl] - __gem list__.
- [prconf] - __ved ~/.pryrc__.
- [prh] - __ved ~/.pry_history__.

#### Git stuff:
- [mt]* - __master__ (your know, THAT branch).
- [h1]* - __HEAD~1__
- [hd]* - __HEAD__ (Where is my head)
- [ga] - __git add__ (you know, adds your stuff to index).
- [gaa] - __git add .; git status -s__ (add stuff, show stuff)
- [gae] - __git add -e__ (when simple __git add__ just isn't enough).
- [gb] - __git --no-pager branch__ (I'm groot!).
- [gbc] - __git branch -c__.
- [gbc!] - __git branch -C__.
- [gbl]  - __gb -l__ (Show me my roots!).
- [gbm] - __git branch -m__.
- [gbm!] - __git branch -M__.
- [gbr] - __git branch -__.
- [gbr!] - __git branch -D__.
- [gbum] - __git branch --no-merged=master__.
- [gc] - __git checkout__.
- [gcb] - __git checkout -b__.
- [gcf] - __git_checkout_feature__.
- [gcl] - __git clone__.
- [gcm] - __git commit -m__.
- [gcma] - __git commit -am__.
- [gcmt] - __git checkout master__.
- [gcp] - __git cherry-pick__. ( :cherries: )
- [gct] - __git checkout --track__.
- [gd] - __git diff --color__
- [gdc] - __git diff --color --cached HEAD__.
- [gf] - __git fetch__.
- [gfix] - __git add . ; git commit --amend__.
- [glog] - Pretty git logs.
- [gpush] - Push current branch to origin.
- [gpush!] - Same as above but with force.
- [grb] - __git rebase__. (Use with care)
- [grba] - __git rebase --abort__.
- [grbc] - __git rebase --continue__.
- [grbi] - __git rebase -i__.
- [grbs] - __git rebase --skip__.
- [gref] - __git pull -r origin master__.
- [grl] - __git reflog__. (In case of REAL emergency)
- [grm] - __git remote__.
- [grma] - __git remote add__.
- [grmd] - __git remote remove__.
- [grmr] - __git remote rename__.
- [grmu] - __git remote get-url__.
- [grmu!] - __git remote set-url__.
- [grmv] - __git remote -v__.
- [grt] - __git reset__.
- [grt!] - __git reset --hard__
- [gsa] - __git stash apply__.
- [gsd] - __git stash drop__.
- [gsh] - __git show__.
- [gsl] - __git stash list__.
- [gss] - __git stash save -u__.
- [gst] - __git status -s__.
- [gwip] - Add all files to index and commit them with temp name. Usefull for fast branch switching.

#### Archlinux stuff (pacman):
- [pacl] - __pacman -Q <package_name>__. (Get stuff in)
- [pacr] - __sudo pacman -R <package_name>__. (Get :poop: out)
- [pacu] - __sudo pacman -Suyy__. (Keep it up to date!)
- [pacc] - __sudo pacman -Scc__. (Clear pacman cache)

#### Systemd stuff:
- [sc] - __sudo systemctl__ (to ctrl 'em all!).
- [scdn]  - __sudo systemctl stop__ (Just die).
- [scdn!] - __sudo systemctl disable__. (...and stay dead).
- [scr] - __sudo systemctl restart__. (rebirth!)
- [scs] - __sudo systemctl status__. (sup?)
- [scup] - __sudo systemctl start__. (Rise and shine)
- [scup!] - __sudo systemctl enable__. (...and stay up)

#### Tmux Stuff:
- [tconf] - __ed ~/.tmux.conf__ (open tux config file in editor)
- [tdc] - __tmux detach-client__.
- [tlc] - __tmux list-clients__.
- [tref] - __tmux source-file ~/.tmux.conf__.
- [tsa] - __tmux attach-session -t__.
- [tsc] - __tmux new-session -s__.
- [tsk] - __tmux kill-session -t__.
- [tsl] - __tmux list-sessions__.
- [tsr] - __restore__.

#### WD stuff:
- [wp] - __wd__ (aka warp directory).
- [wpa] - wd add <name> (add current dir as waypoint named <name>)
- [wpl] - wd list (lists all known waypoints)
- [wpr] - __wd rm__ <name> (remove waypoint named <name>)

#### JS stuff:
- [ya] - __yarn__.
- [yaa]  - __yarn add__.

#### zsh stuff
- [zref] - __source ~/.zshrc__.
- [zref!] - __source ~/.zshrc; clear__.
