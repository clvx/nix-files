#!/bin/bash

#Executing void flake
run() {
    nixos-rebuild switch --flake .#$1
}

# Usage ./run.sh void|abyss
# check whether user had supplied -h or --help . If yes display usage
if [[ ( $@ == "--help") ||  $@ == "-h" ]]
then 
	echo "Usage: $0 <flake>"
	exit 0
fi 

run $1

## adding this at initial setup
#command -v zsh | sudo tee -a /etc/shells
#sudo chsh -s "$(command -v zsh)" "${USER}"
