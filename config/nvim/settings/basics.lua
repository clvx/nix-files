--
local opt = vim.opt
local g = vim.g

-- enabling clipboard
opt.clipboard= "unnamedplus"

-- fugitive vertical split
opt.diffopt = opt.diffopt + 'vertical'

-- supporting devicons
opt.encoding = 'UTF-8'

-- Habilitar Wild menu
opt.wildmenu = true

-- Mostrar posición actual
opt.ruler = true

-- Muestra un comando incompleto
opt.showcmd = true

-- mostrar que el par de los corchetes
opt.showmatch = true

-- enabling true colors
opt.termguicolors = true

-- habilita mouse
opt.mouse = "a"

-- Abrir en el lado derecho
opt.splitright = true

-- Retomar modo normal de backspace
opt.bs = '2'

-- cursor line
opt.cursorline = true

-- autoread
opt.autoread = true

opt.shortmess = "atI"

-- highlight color column
opt.colorcolumn = {'80', '120'}

-- folding
opt.foldmethod = 'expr'
-- https://www.reddit.com/r/neovim/comments/1h34lr4/neovim_now_has_the_builtin_lsp_folding_support/, 
-- not available until 10.0.3
-- opt.foldexpr = 'v:lua.vim.lsp.foldexpr()'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldlevelstart = 99
opt.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldclose:'
opt.foldcolumn = '1'
opt.foldenable = true
opt.foldlevel = 99

-- busquedas insensibles a minusculas y mayusculas
opt.ignorecase = true
opt.smartcase = true
opt.wildignorecase = true
opt.wildignore:append "**/.git/*"
opt.wildignore:append "**/build/*"
opt.wildignore:append "**/node_modules/*"
opt.wildignore:append "**/vendor/*"


opt.path:remove "/usr/include"
opt.path:append "**"

-- indice de lineas
opt.number = true
opt.relativenumber = false

-- Utilizar espacios sobre tabs
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smarttab = true

-- Ignorar viminfo
opt.viminfo = ""
opt.viminfofile = "NONE"

-- Ignorar archivos compilados
opt.wildignore = {'*.o','*~','*.pyc'}

-- configuring invisibles
opt.listchars = {eol = '¬', tab = '▸ '}

-- Configurar backspace para que funcione como debe
opt.backspace = {'eol','start','indent'}
opt.whichwrap = opt.whichwrap + '<,>,h,l'

-- making border rounded
opt.winborder = 'rounded'


vim.cmd [[
    set nobackup
    set nowritebackup
    set noerrorbells
    set noswapfile
]]

-- colorscheme and a enabling transparent backgroun
vim.cmd [[
  colorscheme gruvbox
  highlight Normal     ctermbg=NONE guibg=NONE
  highlight LineNr     ctermbg=NONE guibg=NONE
  highlight SignColumn ctermbg=NONE guibg=NONE
]]

-- resalta las busquedas en tiempo real
opt.hlsearch = true
opt.incsearch = true
vim.api.nvim_create_autocmd('VimEnter', {
    pattern = '*.*',
    desc = 'resalta búsquedas en tiempo real',
    command = 'highlight Search ctermbg=8'
})

-- Adding as a command because .vimrc wasn't getting the changes.
vim.api.nvim_create_autocmd('VimEnter', {
    pattern = '*.*',
    desc = 'Chage column color',
    command = 'highlight ColorColumn ctermbg=16'
})

vim.cmd([[
    vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
]])

-- forcing undercurl
vim.cmd [[
  highlight DiagnosticUnderlineError gui=undercurl guisp=Red
  highlight DiagnosticUnderlineWarn gui=undercurl guisp=Yellow
  highlight DiagnosticUnderlineHint gui=undercurl guisp=Blue
  highlight DiagnosticUnderlineInfo gui=undercurl guisp=Green
]]

