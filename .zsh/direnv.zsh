# https://direnv.net/
#add_to_path "$HOME/dev/alan-eu/alan-apps/.devbox/nix/profile/default/bin"
if which direnv >/dev/null; then
  eval "$(direnv hook zsh)"
fi
