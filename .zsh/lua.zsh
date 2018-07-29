alias lua=lua-5.1
alias luarocks=luarocks-5.1

vilua() {
  # existing?
  file=$(ls [0-9]*.lua | grep -E "^[0-9]*-$1\.lua$")
  if ! test -z "$file"; then
    vi "$file"
  else
    current_idx=$(echo "$(ls [0-9]*.lua|cut -d- -f1|sort -n|tail -n 1) + 1"|bc|xargs printf "%03d\n")
    #echo "current index: $current_idx"
    vi "${current_idx}-$1.lua"
  fi
}

export PATH=$PATH:$HOME/.luarocks/bin
