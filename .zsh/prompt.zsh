# basic dynamic prompt
precmd() {
  # return simple prompt if there
  if ! test -z "$SIMPLE_PROMPT"; then
    PROMPT="$SIMPLE_PROMPT"
    return
  fi

  # char
  last_exit_code=$?
  if [[ $last_exit_code -ne 0 && $last_exit_code -ne 130 ]]; then
    char=$'%F{red}'"($last_exit_code)"$'%#%f'
  else
    char=$'%#'
  fi

  # build header line
  header_line=""

  # git config
  git_root=$(git rev-parse --show-toplevel 2>/dev/null)
  if ! test -z "$git_root"; then
    header_line+=$'%F{240}%BG%b '"$(git rev-parse --abbrev-ref HEAD 2>/dev/null) "$'%f'
  fi

  # kubernetes current context
  #if { echo $PWD | grep -q alan-apps } || { ! test -z "$EXECUTED_KUBECTL" }; then
  #  header_line+=$'%F{blue}%BK%b%f '"$(NO_ECHO=1 kubectl config get-contexts | fgrep '*' | awk '{print $3"/"$5}' 2>/dev/null) "
  #fi

  # kong current admin url
  #if echo $PWD | grep -q /kong && ! test -z "$KONG_ADMIN_ADDR"; then
  #  header_line+=$'%F{18}%B[K]%b%f'"$KONG_ADMIN_ADDR "
  #fi

  # nvm environment
  if test -e "$git_root/.nvmrc" && which nvm >/dev/null; then
    nvmcurrent=$(nvm current)
    header_line+=$'%F{green}%B(N)%b%f'"$nvmcurrent "
  fi

  # heroku
  if ! test -z "$HEROKU_APP"; then
    header_line+=$'%F{magenta}%B(H)%b%f'"$HEROKU_APP "
  fi

  # keep header line if here
  if ! test -z "$header_line"; then
    header_line+=$'\n'
  fi

  # directory
  dir=$(pwd|perl -pe "s#^$HOME#~#; s#orca/workspaces/alan-apps#[O]#; s#dev/alan-eu/alan-apps#[A]#;")

  header_line="$dir $header_line"

  # hour
  hour=$'%F{240}%D{%H:%M:%S}%f'

  # host
  userhost=""
  if ! test -z "$SSH_CONNECTION"; then
    #other ssh-accessed machines
    userhost=" %n@%m"
  fi

  PROMPT=$'\n'"$header_line$hour$userhost $char "
}

# precmd() for rvm prompt + no hist dirs
function __precmd() {
  if ! test -z "$SIMPLE_PROMPT"; then
    PROMPT="$SIMPLE_PROMPT"
  else
    dir=$(pwd|perl -pe "s#^$HOME#~#; s#orca/workspaces/alan-apps#[O]#; s#dev/alan-eu/alan-apps#[A]#;")
    PROMPT="$dir%# "
  fi
}

# switch between simple and normal prompt
function sp() {
  if [ "$SIMPLE_PROMPT" ]; then
    unset SIMPLE_PROMPT
  else
    #export SIMPLE_PROMPT="%1d%# "
    export SIMPLE_PROMPT="%# "
  fi
}

# default prompt
export SIMPLE_PROMPT="%# "
