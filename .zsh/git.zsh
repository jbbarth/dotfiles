export GIT_EDITOR=vi
export GPG_TTY=$(tty)
alias g='git'
alias gs='git status -sb'
alias gd='git diff'
gp() {
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  if echo "$current_branch" | grep -qE '^(master|main|devel|acceptance)$'; then
    read "answer?You're about to push to a MAIN branch, are you sure? [y/N] "
    if ! echo "$answer" | grep -qE '^y'; then
      echo "aborting..."
      return
    fi
  fi
  git push origin HEAD $*
}
alias gitx='open -a GitX'
gc() {
  # todos
  git status --porcelain | grep -e "^M" -e "^A" >/dev/null || ( cd $(git root); git add . )
  msg="$1"
  shift
  opts=""
  if [ "$msg" != "" ]; then
    git commit -e -m "$msg" "$@"
  else
    git commit "$@"
  fi
}
gr() {
  git rebase $(git merge-base HEAD acceptance)
}
gclone() {
  url=$1
  echo $url | grep -q github.com || url=$(echo "$url" | perl -pe 's#^#git\@github.com:#')
  repo=$(echo $url | perl -pe 's#^(git\@github\.com:|https://github\.com/)##; s#\.git$##')
  git clone $url $repo
  cd $repo
}
todos() {
  # cd $(git root)
  if test -e .git/ignoretodos; then
    echo "TODOs display is disabled because you have a .git/ignoretodos file"
  else
    git ls-files | xargs ack --with-filename --no-recurse --nobreak --color "TODO:|FIXME:" | grep -v ".yarn/" | perl -pe "s#$(git root)/##" | wrap200
    git ls-files | ack '.md$' | xargs ack --with-filename --no-recurse --nobreak --color 'TODO( |$)' | perl -pe "s#$(git root)/##" | wrap200
  fi
  #cd - >/dev/null
}
wrap200() {
  perl -pe 's/^(.{0,200})(.*)$/$1.($2?"...":"")/e'
}
if false && which hub >/dev/null; then
  # do not use an alias or shell comp won't work
  function git(){hub "$@"}
fi

gsync() {
  if [ "$(git status --short)" != "" ]; then
    echo "Error: clean up your git status first!" >&2
    return
  fi
  git branch|grep -q devel && branch=devel || branch=master
  git branch|grep -q acceptance && branch=acceptance
  echo "> git checkout $branch"
  git checkout $branch
  echo "> hub sync"
  hub sync || echo "failed"
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
alias ga="git add -N . && git add -p"

# graphite
alias gtl="gt log short"
alias gtr="gt rs -r"
gts() { gt ss -r && prurl }
