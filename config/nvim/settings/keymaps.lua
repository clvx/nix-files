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
map('n','<leader>fF', ':FzfLua git_files<CR>')
map('n','<leader>fC', ':FzfLua git_commits<CR>')
map('n','<leader>fB', ':FzfLua builtin<CR>')
map('n','<leader>fc', ':FzfLua commands<CR>')
map('n','<leader>fm', ':FzfLua keymaps<CR>')


---------------
--- fzf-lua ---
---------------
map('n','<leader>lr', ':FzfLua lsp_references<CR>')
map('n','<leader>ld', ':FzfLua lsp_definitions<CR>')
map('n','<leader>lD', ':FzfLua lsp_declarations<CR>')
map('n','<leader>li', ':FzfLua lsp_implementations<CR>')
map('n','<leader>lds', ':FzfLua lsp_document_symbols<CR>')
map('n','<leader>lws', ':FzfLua lsp_workspace_symbols<CR>')
map('n','<leader>lca', ':FzfLua lsp_code_actions<CR>')
map('n','<leader>lic', ':FzfLua lsp_incoming_calls<CR>')
map('n','<leader>loc', ':FzfLua lsp_outgoing_calls<CR>')
map('n','<leader>ldd', ':FzfLua lsp_document_diagnostics<CR>')
map('n','<leader>ldw', ':FzfLua lsp_workspace_diagnostics<CR>')

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
