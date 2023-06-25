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
    nix run . switch -- --flake .#<flake>
    hash -r
    ```

3. Update 

    ```
    nix flake update
    nix run . switch -- --flake .#<flake>
    ```

## TODOs


### NVIM

[ ] Not very happy with nix-cmp. It requires work to give it the same UX as coc.vim.

- tab support

- selecting item

- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion

- https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/

[ ] Fix nvim-tree opening new buffer instead of replacing it.

- https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt

[ ] Review different mappings:

- nvim-lspconfig

- nvim-cmp

[ ] unmap default fzf-lua commands

[ ] Dig into lsp-config keymaps

[ ] Review go.nvim
- https://github.com/ray-x/go.nvim
- https://medium.com/@yanglyu5201/neovim-setup-for-golang-programming-68ebf59336d9

- [ ] Lacking tags - heirline.nvim could be useful for this.

- https://neovim.io/doc/user/lua.html

