# Nix files


A bunch of files managed by Nix home-manager.

## Install

1. Install Nix

    ```
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    exec $SHELL -l
    ```

2. Install files

    ```
    git clone git@github.com:clvx/nix-files.git
    cd ./nix-files
    nix run . switch -- --flake .
    hash -r
    ```

## TODOs

[ ] Not very happy with nix-cmp. It requires work to give it the same UX as coc.vim.
- tab support
- selecting item
[ ] Review different mappings:
- nvim-lspconfig
- nvim-cmp
