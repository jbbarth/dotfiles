export PYTHONPATH=.
export PYTHONDONTWRITEBYTECODE=true
export PYTHONUNBUFFERED=1

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

add_to_path $HOME/.pyenv/versions/3.6.3/bin after

#export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
