export PYTHONPATH=.
export PYTHONDONTWRITEBYTECODE=true

workon() {
  cd $1
  project=$(readlink -f $(pwd)|xargs basename)
  venv="$HOME/.virtualenvs/$project"
  if ! test -e "$venv"; then
    echo "Creating virtualenv $project"
    virtualenv "$venv"
  fi
  echo "Loading virtualenv $project"
  source "$venv/bin/activate"
}
