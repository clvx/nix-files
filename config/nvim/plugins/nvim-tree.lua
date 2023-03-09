local g = vim.g
-- disable netrw at the very start of your init.lua (strongly advised)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup()
