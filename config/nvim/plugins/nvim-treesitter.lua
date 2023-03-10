-- Defines a read-write directory for treesitters in nvim's cache dir
local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
vim.fn.mkdir(parser_install_dir, "p")

-- Prevents reinstall of treesitter plugins every boot
vim.opt.runtimepath:append(parser_install_dir)


require'nvim-treesitter.configs'.setup {

  -- uses the custom parser directory
  parser_install_dir = parser_install_dir,

  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  --ensure_installed = { "c", "lua", "vim", "help", "query" },
  --ensure_installed = "maintained",
  ensure_installed = "",

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  --ignore_install = { "javascript" },

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
