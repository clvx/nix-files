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
map('n','<leader>fk', ':FzfLua keymaps<CR>')


---------------
--- fzf-lua ---
---------------
map('n','<leader>lr', ':FzfLua lsp_references<CR>')
map('n','<leader>lD', ':FzfLua lsp_declarations<CR>')
map('n','<leader>lca', ':FzfLua lsp_code_actions<CR>')
map('n','<leader>lde', ':FzfLua lsp_definitions<CR>')
map('n','<leader>ldd', ':FzfLua lsp_document_diagnostics<CR>')
map('n','<leader>lds', ':FzfLua lsp_document_symbols<CR>')
map('n','<leader>ldw', ':FzfLua lsp_workspace_diagnostics<CR>')
map('n','<leader>lic', ':FzfLua lsp_incoming_calls<CR>')
map('n','<leader>lim', ':FzfLua lsp_implementations<CR>')
map('n','<leader>loc', ':FzfLua lsp_outgoing_calls<CR>')
map('n','<leader>lws', ':FzfLua lsp_workspace_symbols<CR>')

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

-----------------------
--- Noice fzf-lua ----
map("n","<leader>nl",":Noice last<CR>")
map("n","<leader>nf",":Noice files<CR>")
map("n","<leader>ne",":Noice errors<CR>")
map("n","<leader>nd",":Noice dismiss<CR>")

-- search for selected word in visual mode
--vim.keymap.set('v', '//', 'y/\V<C-R>=escape(@",'/\')<CR><CR>', {
--    noremap = true,
--    desc = 'search for selected words in visual mode'
--}) 

-------------------------------------------------
-- Exports on_attach options for each lspconfig--
-------------------------------------------------
-- Exporting on_attach
CUSTOM_KEYMAP = {}

-- LSP Mappings.
local opts = { noremap=true, silent=true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
CUSTOM_KEYMAP.on_attach = function(bufnr)
--package.preload.on_attach_keymaps = function(bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>c', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  --return {on_attach_keymaps = self}
end

return CUSTOM_KEYMAP
-------------------------------------------------
-- /////////////////////////////////////////// --
-------------------------------------------------
