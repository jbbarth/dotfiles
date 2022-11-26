# shell completion
complete -C '/usr/local/bin/aws_completer' aws

# remove warnings when using brew provided 'aws'
#alias aws="env PYTHONWARNINGS=ignore aws"

function aws-env {
  # adapted from https://stackoverflow.com/a/63816729/278757
  emulate -LR zsh
  profile=${1:-default}
  if [[ ${profile} == clear ]]; then
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SESSION_TOKEN
    unset AWS_SECRET_KEY
  else
    AWS_ACCESS_KEY_ID="$(aws configure get aws_access_key_id --profile ${profile})" || return 1
    AWS_SECRET_ACCESS_KEY="$(aws configure get aws_secret_access_key --profile ${profile})" || return 1
    export AWS_ACCESS_KEY_ID
    export AWS_SECRET_ACCESS_KEY
  fi
}
