# https://direnv.net/
#add_to_path "$HOME/dev/alan-eu/alan-apps/.devbox/nix/profile/default/bin"
if which direnv >/dev/null; then
  eval "$(direnv hook zsh)"
  #nohup tmutil addexclusion /Users/jean-baptiste.barth/dev/alan-eu/alan-apps/.direnv >/dev/null 2>/dev/null &
fi
