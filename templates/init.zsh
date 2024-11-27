# TODO: Override defaults here to you preferance, just uncomment right env variable and change it accordingly to you needs.

export LC_CTYPE=en_US.UTF-8

# export EDITOR="nano"
# export VISUAL="codium"
# export BROWSER="vivaldi-stable"
# export GIT_EDITOR="nano"

export DOTFILES_QUIET=false
export DOTFILES_VERBOSE=false

export TMUX_AUTORESTORE=true

export CAPACITOR_ANDROID_STUDIO_PATH=/usr/bin/android-studio

# o-din stuff
# Спиcок наших гемов модулей
gems=(
  o-din
  o-din-maintenance
  o-din-audit
  o-din-director
  o-din-ku
  o-din-parking
  o-din-pm
  o-din-ppr
  o-din-rounds
  o-din-stock
  o-din-turnover
  o-din-lk
  o-din-report
)

PROJECTS_DIR=${PROJECTS_DIR:-$HOME/projects}

# Обновляет все модули на указанных проектах
# $ _update_projects demo o1 rekafm
function _update_projects() {
  # Схороним текущую директорию, понадобится потом ибо надо будет скакать по директориям.
  local cwd=$(pwd)
  # Адский баш по умолчанию использует для массива for все аргументы. Абузим))
  for project
  do
    echo -e "\033[32m [*] updating $project ...\033[0m"
    # TODO: Путь пока захардкожен, вынести в переменную
    # Идем в папку с репозиторием проекта
    cd $PROJECTS_DIR/$project
    # Если вдруг в репе грязненько - прячем всю каку в стеш
    git stash 1>/dev/null 2>&1
    # Ежели веточка не мастер - го в мастер
    if [[ _git_curent_branch -ne 'master' ]]; then
      git checkout master 1>/dev/null 2>&1
    fi
    # Пулим свежатину, с ребейзом
    git pull --rebase 1>/dev/null 2>&1
    # Мой чит для обновления проектов, см выше
    upd "${gems[@]}" 1>/dev/null 2>&1
    # JS тоже обновим на свежее
    yarn upgrade o-din-package 1>/dev/null 2>&1
    # Коммитимся
    git commit -am ":arrow_up: Update gems" 1>/dev/null 2>&1
    # Пушимся
    git push 1>/dev/null 2>&1
  done
  # После всех проделанных манипуляций возращаем пользователя туда где он был
  cd $cwd
}
# У меня лапки, поэтому все функции мнемонически заалиасены
alias upda="_update_projects"

# Обновляет все локальные гемы на свежий мастер
function _update_gems() {
  # Уже было
  local cwd=$(pwd)

  # Итерируемся по всем модулям
  for gem in ${gems[*]}
  do
    # TODO: Путь пока захардкожен, вынести в переменную
    # Идем в папку с репозиторием модуля, остальные действия описаны в функции выше
    cd $PROJECTS_DIR/$gem
    git stash 1>/dev/null 2>&1
    if [[ _git_curent_branch -ne 'master' ]]; then
      git checkout master 1>/dev/null 2>&1
    fi
    git pull --rebase 1>/dev/null 2>&1
    echo -e "\033[32m [*] updating $gem ...\033[0m"
    cd $cwd
  done
}
# У меня лапки, поэтому все функции мнемонически заалиасены
alias updg="_update_gems"

## Мобилка

# Сборка МП андройда указанного проекта
function _build_android() {
  node build.js --app $1 --platform android --resources && cd apps/$1 && npx cap open android && cd ../..
}
# У меня лапки, поэтому все функции мнемонически заалиасены
alias abuild="_build_android"

# Сборка МП iOS указанного проекта
function _build_ios() {
  node build.js --app $1 --platform ios --resources && cd apps/$1 && npx cap open ios && cd ../..
}
# У меня лапки, поэтому все функции мнемонически заалиасены
alias ibuild="_build_ios"
