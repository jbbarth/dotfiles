autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C $(which terraform) terraform
