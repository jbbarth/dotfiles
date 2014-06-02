export GIT_EDITOR=vi
alias g='git'
alias gs='git status -sb'
gc() {
  git status --porcelain | grep -e "^M" -e "^A" >/dev/null || git add .
  opts=""
  if [ "$1" != "" ]; then
    git commit -e -m "$1"
  else
    git commit
  fi
}
gp() {
  if grep "remote = origin" .git/config >/dev/null; then
    git push --all origin
  elif [ -s .git/FETCH_HEAD ]; then
    git push --all $(ruby -ne 'puts $_.split.pop' < .git/FETCH_HEAD).git
  elif test -f .git/config && grep "origin" .git/config >/dev/null; then
    git push origin master
  else
    echo -n "Repo: "
    read repo
    git push --all $repo
  fi  
}
if which hub >/dev/null; then
  # do not use an alias or shell comp won't work
  function git(){hub "$@"}
fi
