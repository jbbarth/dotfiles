# GIT

export GIT_EDITOR=vi
alias g='git'
alias gc='git status --porcelain | grep "^M" >/dev/null || git add . ; git commit'
alias gs='git status'
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
