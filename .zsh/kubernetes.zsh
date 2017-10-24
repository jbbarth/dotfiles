alias kb="kubectl"
kbtail() {
  # Find a pod matching the pattern passed as first argument and then
  # waits for it to be in "Running" state before running a
  # "kubectl logs -f ..." on it. This VS running "kubectl logs -f"
  # that will break when container not ready.
  while :; do
    podline=$(kubectl get pods --no-headers | grep --color=no -E "$1")
    clear
    date
    echo "$podline"
    if echo "$podline" | grep -q Running; then
      break
    else
      sleep 1
    fi
  done
  pod=$(echo "$podline" | head -n 1 | awk '{print $1}')
  kubectl logs -f $pod
}
