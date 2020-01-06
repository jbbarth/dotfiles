# RVM: Ruby Version Manager
# https://rvm.io/

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

  # Add RVM to PATH for scripting
  add_to_path $rvm_path/bin
fi
