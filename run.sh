#!/usr/bin/env bash

HOST="$1"
shift # Remove the first argument (the hostname) from the list of arguments
CURRENT=$(hostname)

if [[ "$HOST" != "$CURRENT" ]]; then
    echo "This script is intended to be run on $HOST, but the current hostname is $CURRENT."
    exit 1
fi

echo ${HOST}

nixos-rebuild switch --flake .#${HOST} $@


## adding this at initial setup
#command -v zsh | sudo tee -a /etc/shells
#sudo chsh -s "$(command -v zsh)" "${USER}"
