_hub_repos() {
  local user="${1?}"
  shift 1
  _hub_paginate hub api -t graphql -f user="$user" "$@" -f query='
    query($user: String!, $per_page: Int = 100, $after: String) {
      repositoryOwner(login: $user) {
        repositories(first: $per_page, after: $after) {
          nodes {
            nameWithOwner
          }
          pageInfo {
            hasNextPage
            endCursor
          }
        }
      }
    }
  '
}

_hub_paginate() {
  local output cursor
  output="$("$@")"
  cursor="$(awk '/\.hasNextPage/ { has_next=$2 } /\.endCursor/ { if (has_next=="true") print $2 }' <<<"$output")"
  printf "%s\n" "$output"
  [ -z "$cursor" ] || _hub_paginate "$@" -f after="$cursor"
}

hub_current_user() {
  hub api --flat user | grep .login | awk '/.login/ {print $2}'
}

hub_repos() {
  local user="${1?}"
  shift 1
  _hub_repos "$user" | awk '/\.nameWithOwner\t/ { print $2 }' | sort
}
