export GIT_EDITOR=vi
alias g='git'
alias gs='git status -sb'
alias gd='git diff'
alias gp='git push origin HEAD'
alias gitx='open -a GitX'
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
  # cd $(git root)
  if test -e .git/ignoretodos; then
    echo "TODOs display is disabled because you have a .git/ignoretodos file"
  else
    git ls-files | xargs ack --no-recurse --nobreak --color "TODO:|FIXME:" | perl -pe "s#$(git root)/##" | wrap200
    git ls-files | ack '.md$' | xargs ack --no-recurse --nobreak --color 'TODO( |$)' | perl -pe "s#$(git root)/##" | wrap200
  fi
  #cd - >/dev/null
}
wrap200() {
  perl -pe 's/^(.{0,200})(.*)$/$1.($2?"...":"")/e'
}
if which hub >/dev/null; then
  # do not use an alias or shell comp won't work
  function git(){hub "$@"}
fi
alias git='LANG=C hub'

gsync() {
  set -e
  if [ "$(git status --short)" != "" ]; then
    echo "Error: clean up your git status first!" >&2
    return
  fi
  git branch|grep -q devel && branch=devel || branch=master
  echo "> git checkout $branch"
  git checkout $branch
  echo "> git sync"
  git sync
  echo "> git cleanup"
  git cleanup
}

gcleanup() {
  git branch --format="%(refname:short)" | grep -qE '^devel$' && main=devel || main=master
  git checkout -q $main && git for-each-ref refs/heads/ --format="%(refname:short)" | while read branch; do
    merge_base=$(git merge-base $main $branch)
    if [[ $(git cherry $main $(git commit-tree $(git rev-parse $branch^{tree}) -p $merge_base -m _)) == "-"* ]]; then
      git branch -D $branch
    fi
  done
}
