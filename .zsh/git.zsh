export GIT_EDITOR=vi
alias g='git'
alias gs='git status -sb'
alias gd='git diff'
alias gp='git push'
gc() {
  todos
  git status --porcelain | grep -e "^M" -e "^A" >/dev/null || ( cd $(git root); git add . )
  opts=""
  if [ "$1" != "" ]; then
    git commit -e -m "$1"
  else
    git commit
  fi
}
todos() {
  cd $(git root)
  if test -e .git/ignoretodos; then
    echo "TODOs display is disabled because you have a .git/ignoretodos file"
  else
    git ls-files | xargs ack --no-recurse --nobreak --color "TODO:|FIXME:" | perl -pe "s#$(git root)/##" | wrap200
    git ls-files | ack '.md$' | xargs ack --no-recurse --nobreak --color 'TODO( |$)' | perl -pe "s#$(git root)/##" | wrap200
  fi
  cd - >/dev/null
}
wrap200() {
  perl -pe 's/^(.{0,200})(.*)$/$1.($2?"...":"")/e'
}
if which hub >/dev/null; then
  # do not use an alias or shell comp won't work
  function git(){hub "$@"}
fi
