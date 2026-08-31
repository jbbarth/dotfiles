# https://direnv.net/
#add_to_path "$HOME/dev/alan-eu/alan-apps/.devbox/nix/profile/default/bin"
if which direnv >/dev/null; then
  # eval "$(direnv hook zsh)"

  # NB: adding "time" below
  _direnv_hook() {
  trap -- '' SIGINT
    dir="$(test -e ~/dev/alan-eu/alan-apps/.devbox/nix/profile/default/bin/direnv && echo "$HOME/dev/alan-eu/alan-apps/.devbox/nix/profile/default/bin/" || which direnv|direname)"
    eval "$("$dir/direnv" export zsh)"
    trap - SIGINT
  }
  typeset -ag precmd_functions
  if (( ! ${precmd_functions[(I)_direnv_hook]} )); then
    #precmd_functions=(time _direnv_hook $precmd_functions)
    precmd_functions=(_direnv_hook $precmd_functions)
  fi
  typeset -ag chpwd_functions
  if (( ! ${chpwd_functions[(I)_direnv_hook]} )); then
    #chpwd_functions=(time _direnv_hook $chpwd_functions)
    chpwd_functions=(_direnv_hook $chpwd_functions)
  fi
fi
