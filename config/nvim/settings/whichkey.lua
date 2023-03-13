--local M = {}

--function M.setup()
  local whichkey = require "which-key"

  local conf = {
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
    },
  }

  local opts = {
    mode = "n", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local mappings = {
    ["w"] = { "<cmd>update!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },

    b = {
      name = "Buffer",
      q = { "<Cmd>bd!<Cr>", "Close current buffer" },
      D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
    },

    ["<leader>"] = {
        n = { "<cmd>NvimTreeToggle<CR>", "NvimTree" },
        f = {
          name = "FZF",
          f = { "<cmd>FzfLua files<cr>", "Files" },
          b = { "<cmd>FzfLua buffers<cr>", "Buffers" },
          l = { "<cmd>FzfLua lines<cr>", "Lines" },
          t = { "<cmd>FzfLua tags<cr>", "Tags" },
          g = { "<cmd>FzfLua grep<cr>", "Grep" },
          F = { "<cmd>FzfLua git_files<cr>", "Git Files" },
          C = { "<cmd>FzfLua git_commits<cr>", "Git Commits" },
          B = { "<cmd>FzfLua builtin<cr>", "Builtin" },
          c = { "<cmd>FzfLua commands<cr>", "Commands" },
          m = { "<cmd>FzfLua keymaps<cr>", "Keymaps" },
      },
        l = {
          r = { ":FzfLua lsp_references<CR>", "References" },
          d = { ":FzfLua lsp_definitions<CR>", "Definitions" },
          D = { ":FzfLua lsp_declarations<CR>", "Declarations" },
          i = { ":FzfLua lsp_implementations<CR>", "Implementations" },
          s = {  ":FzfLua lsp_document_symbols<CR>", "Document Symbols" },
          S = {  ":FzfLua lsp_workspace_symbols<CR>", "Workspace Symbols" },
          --ca = {  ":FzfLua lsp_code_actions<CR>", "Code Actions" },
          --ic = {  ":FzfLua lsp_incoming_calls<CR>", "Incoming Calls" },
          --oc = {  ":FzfLua lsp_outgoing_calls<CR>", "Outgoing Calls" },
          --dd = {  ":FzfLua lsp_document_diagnostics<CR>", "Document Diagnostics" },
          --dw = {  ":FzfLua lsp_workspace_diagnostics<CR>", "Workspace Diagnostics" },
        },
    },
  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
--end
--
--return M
