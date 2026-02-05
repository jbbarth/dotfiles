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
  if { echo $PWD | grep -v /dev/kubernetes | grep -q /kube; } || { test -e "$git_root/zapp.yml.j2" } || { ! test -z "$EXECUTED_KUBECTL" }; then
    header_line+=$'%F{blue}\u{2388}%f '"$(NO_ECHO=1 kubectl config current-context) "
  fi

  # kong current admin url
  if echo $PWD | grep -q /kong && ! test -z "$KONG_ADMIN_ADDR"; then
    header_line+=$'%F{18}%B[K]%b%f'"$KONG_ADMIN_ADDR "

  fi

  # virtualenvs
  if ! test -z "$VIRTUAL_ENV"; then
    venv=$(echo "$VIRTUAL_ENV" | \
             perl -pe "s#^$HOME#~#;s#~/(.virtualenvs|.local/share/virtualenvs)/##;" | \
             perl -pe 's#~/.pyenv/versions/([^/]+)/envs/([^/]+)$#$1/$2#')
    header_line+=$'%F{green}%B(P)%b%f'"$venv "
  fi

  # rvm gemset
  if test -e "$git_root/.ruby-version"; then
    gemset=$(cat $git_root/.ruby-version)
    test -e "$git_root/.ruby-gemset" && gemset+="@$(cat $git_root/.ruby-gemset)"
    header_line+=$'%F{red}%B(R)%b%f'"$gemset "
  fi

  # nvm environment
  if test -e "$git_root/.nvmrc" && which nvm >/dev/null; then
    nvmcurrent=$(nvm current)
    header_line+=$'%F{green}%B(N)%b%f'"$nvmcurrent "
  fi

  # heroku
  if ! test -z "$HEROKU_APP"; then
    header_line+=$'%F{magenta}%B(H)%b%f'"$HEROKU_APP "
  fi

  # terraspace
  if test -e "$(pwd)/.terraform"; then
    ts_env=${TS_ENV:-dev}
    header_line+=$'%F{blue}%B(T)%b%f'"$ts_env "
  fi

  # keep header line if here
  if ! test -z "$header_line"; then
    header_line+=$'\n'
  fi

  # directory
  dir=$(echo $PWD | sed "s#^$HOME#~#")
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
    dir=$(pwd|perl -pe 's#^/(Users|home)/jbbarth#~#;s#^~/(botify|dev/botify|Projects/botify)#[B]#')
    if which ec2metadata >/dev/null; then
      #AWS machines
      env=$(ec2metadata --security-groups|head -n 1|cut -d. -f4|sed 's#%2F#/#')
      [ "$env" == "prod" ] && env="%{$fg[red]%}prod"
      [ "$env" == "staging" ] && env="%{$fg[cyan]%}staging"
      userhost="$env%{$reset_color%}|%n@%m"
    elif test -e /usr/local/rtm/bin/rtm; then
      #OVH machines
      env="%{$fg[blue]%}ovh"
      userhost="$env%{$reset_color%}|%n@%m"
    elif ! test -z "$SSH_CONNECTION"; then
      #other ssh-accessed machines
      userhost="%n@%m"
    else
      userhost="%n@local"
    fi
    if [ "$VIRTUAL_ENV" != "" ]; then
      virtualenv="($(basename $VIRTUAL_ENV))"
    else
      virtualenv=""
    fi
    if test -e $(pwd)/.ruby-version; then
      rvm_env="{$(current_rvm_env)}"
    else
      rvm_env=""
    fi

    PROMPT="$rvm_env$virtualenv$userhost:$dir%# "
  fi
  PROMPT='$(kube_ps1)'$PROMPT
}

# switch between simple and normal prompt
function sp() {
  if [ "$SIMPLE_PROMPT" ]; then
    unset SIMPLE_PROMPT
  else
    export SIMPLE_PROMPT="%1d%# "
  fi
}

# uncomment to use a simple prompt by default
sp
