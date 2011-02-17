# RVM: Ruby Version Manager
# http://rvm.beginrescueend.com/

#loading
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
[[ -s /usr/local/rvm/scripts/rvm ]] && source /usr/local/rvm/scripts/rvm

#short current rvm env
current_rvm_env() {
  res=${GEM_HOME/*\/}
  res=${res/ruby-}
  res=$(echo $res|perl -pe 's/-p\d+($|@)/\1/')
  echo $res
}

#prompt with rvm env
function precmd() {
  PROMPT="%m:$(current_rvm_env)%# "
}
