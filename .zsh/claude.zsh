claude() {
  rootdir="$(git rev-parse --show-toplevel 2>/dev/null)"
  if echo "$rootdir" | grep -q "/dev/"; then
    cd "$rootdir"
  fi

  local has_name=0
  for arg in "$@"; do
    case "$arg" in
      -n|--name|--name=*) has_name=1; break ;;
    esac
  done

  if (( has_name )); then
    command claude "$@"
  else
    command claude --name "claude-$(uuidgen | tr '[:upper:]' '[:lower:]')" "$@"
  fi
}
