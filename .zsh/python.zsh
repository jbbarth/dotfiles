export PYTHONPATH=.
export PYTHONDONTWRITEBYTECODE=true

bblack() {
  docker run -v $(pwd):/code jbbarth/black $*
}

workon() {
  [[ "$1" != . ]] && cd $1
  project=$(readlink -f $(pwd)|xargs basename)
  venv="$HOME/.virtualenvs/$project"
  if ! test -e "$venv"; then
    echo "Creating virtualenv $project"
    virtualenv "$venv"
  fi
  echo "Loading virtualenv $project"
  source "$venv/bin/activate"
}

export PATH=$PATH:$HOME/.pyenv/versions/3.6.3/bin

#export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
