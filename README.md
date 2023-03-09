# Nix files


A bunch of files managed by Nix home-manager.

## Install

1. Install Nix

    ```
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    ```

2. Install files

    ```
    git clone git@github.com:clvx/nix-files.git
    nix run . switch -- --flake .
    hash -r
    ```
