#!/bin/sh
sleep 5
if [ -e "/usr/bin/conky" ] && [ ! -z "$XAUTHORITY" ] && ! pgrep conky>/dev/null; then
  if [ -s "$HOME/.conky/conkyrc.$(hostname)" ]; then
    conky -c $HOME/.conky/conkyrc.$(hostname) -d -q
  elif [ -s "$HOME/.conky/conkyrc" ]; then
    conky -c $HOME/.conky/conkyrc -d -q
  fi
fi
