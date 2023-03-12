-- key mapping function
local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

---------------
-- nvim-tree --
---------------
map('','<leader>n', ':NvimTreeToggle<CR>')

---------------
--- fzf-lua ---
---------------
map('n','<leader>f', ':FzfLua files<CR>')
map('n','<leader>fb', ':FzfLua buffers<CR>')
map('n','<leader>fl', ':FzfLua lines<CR>')
map('n','<leader>ft', ':FzfLua tags<CR>')
map('n','<leader>fg', ':FzfLua grep<CR>')
map('n','<leader>fgf', ':FzfLua git_files<CR>')
map('n','<leader>fgc', ':FzfLua git_commits<CR>')
map('n','<leader>fbi', ':FzfLua builtin<CR>')
map('n','<leader>fnc', ':FzfLua commands<CR>')
map('n','<leader>fm', ':FzfLua keymaps<CR>')

-----------------------
-- buffer navigation --
-----------------------
map('','<C-h>','<C-w>h')
map('','<C-j>','<C-w>j')
map('','<C-k>','<C-w>k')
map('','<C-l>','<C-w>l')
--- tab navigation ----
map('','<c-t>','<esc>:tabnew<cr>')
map('','<c-[>','gT')
map('','<c-]>','gt')
----- close buffer ----
map('n','<leader>q',':bd<CR>')
