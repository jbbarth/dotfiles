if test -d "$HOME/dev"; then
  export CDPATH=$CDPATH:$HOME/dev
  for dir in $HOME/dev/*; do
    test -d $dir || continue
    export CDPATH=$CDPATH:$dir
  done
fi
