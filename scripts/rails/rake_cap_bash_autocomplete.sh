#see: http://blog.xilinus.com/2009/1/3/rake-and-cap-auto-complete-for-bash-shell
export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}
 
_rakecomplete() {
  COMPREPLY=($(compgen -W "`rake -s -T 2>/dev/null | awk '{{print $2}}'`" -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}
 
_capcomplete() {
  COMPREPLY=($(compgen -W "`cap -T 2>/dev/null| awk '{{ if ( $3 ~ /\#/ ) print $2}}'`" -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}
 
complete -o default -o nospace -F _rakecomplete rake
complete -o default -o nospace -F _capcomplete cap
