-- key mapping function
local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local g = vim.g
-- disable netrw at the very start of your init.lua (strongly advised)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup({
    actions = {
        open_file = {
            window_picker = {
                enable = false,
            },
        },
    },
})

map('','<leader>n', ':NvimTreeToggle<CR>')
