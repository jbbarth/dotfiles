if [ -e "/usr/bin/conky" && ! -z "$XAUTHORITY" ]; then
  if [ -s "$HOME/.conky/conkyrc.$(hostname)" ]; then
    conky -c $HOME/.conky/conkyrc.$(hostname) -d -q
  else if [ -s "$HOME/.conky/conkyrc" ]; then
    conky -c $HOME/.conky/conkyrc -d -q
  fi
fi
