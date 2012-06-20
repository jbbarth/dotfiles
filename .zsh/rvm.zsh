# RVM: Ruby Version Manager
# http://rvm.beginrescueend.com/

#loading
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
[[ -s /usr/local/rvm/scripts/rvm ]] && source /usr/local/rvm/scripts/rvm

#continue only if the machine has an RVM setup
if type rvm >/dev/null 2>&1; then

  #short current rvm env
  current_rvm_env() {
    res=${GEM_HOME/*\/}
    res=${res/ruby-}
    res=$(echo $res|perl -pe 's/-p\d+($|@)/\1/')
    echo $res
  }

  #prompt with rvm env
  function precmd() {
    if [[ -z "$SSH_CONNECTION" ]]; then
      #PROMPT="$(printf '\u263A'):$(current_rvm_env)%# "
      PROMPT="local:$(current_rvm_env)%# "
    else
      PROMPT="%m:$(current_rvm_env)%# "
    fi
  }

  #add RVM to PATH for scripting
  PATH=$PATH:$HOME/.rvm/bin

  #forces to load per project file in screen
  cd .

fi
