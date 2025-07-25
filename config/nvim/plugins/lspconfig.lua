--
-- Configurations of nvim lsp: https://neovim.io/doc/user/lsp.html#_quickstart
-- https://gpanders.com/blog/whats-new-in-neovim-0-11/#simpler-lsp-setup-and-configuration
--

-- Enabling LSP servers
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('lua_ls')
vim.lsp.enable('ruff_lsp')
vim.lsp.enable('ts_ls')
vim.lsp.enable('gopls')
vim.lsp.enable('pyright')
vim.lsp.enable('nixd')

-- 
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})


-- enable diagnostics
vim.diagnostic.config({
  -- Use the default configuration
  virtual_lines = true

  -- Alternatively, customize specific options
  -- virtual_lines = {
  --  -- Only show virtual line diagnostics for the current cursor line
  --  current_line = true,
  -- },
})

