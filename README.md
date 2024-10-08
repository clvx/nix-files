# Nix files

A bunch of Linux configurations managed by Nix Flakes

## Install NixOS

After installing, execute:

    nixos-build switch --flake .#<flake-output>

## Install standalone

1. Install Nix


    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    exec $SHELL -l
    ```

2. Install files

    ```
    git clone git@github.com:clvx/nix-files.git
    cd ./nix-files
    nix run . switch -- --flake .#<flake>
    hash -r
    ```

3. Update 


    nix flake update
    nix run . switch -- --flake .#<flake>
    ```

4. Upgrade
    
    Update the nixpkgs and home-manager versions to the latest NixOS version and 
    run update.

## TODOs


### NVIM

[ ] Not very happy with nix-cmp. It requires work to give it the same UX as coc.vim.

[ ] tab support

[ ] selecting item

[ ] https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion

[ ] https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/

[ ] Fix nvim-tree opening new buffer instead of replacing it.

[ ] https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt

 [ ] Lacking tags - heirline.nvim could be useful for this.

[ ] https://neovim.io/doc/user/lua.html
