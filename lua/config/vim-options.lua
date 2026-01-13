--stylua: ignore
local opt = vim.opt

-- Basic Behavior
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.undofile = true -- Persistent undo
opt.mouse = "a" -- Enable mouse support
opt.updatetime = 250 -- Faster response (LSP/Gitsigns)
opt.timeoutlen = 300 -- Faster key sequence completion

-- Indenting
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.breakindent = true

-- UI Appearance
vim.wo.number = true
vim.wo.relativenumber = true
opt.termguicolors = true -- True color support
opt.signcolumn = "yes" -- Prevent text shifting
opt.cursorline = true -- Highlight current line
opt.scrolloff = 10 -- Keep lines above/below cursor
opt.laststatus = 3 -- Global statusline
opt.fillchars = { eob = " " } -- Hide the '~' on empty lines at end of buffer

-- Search and Replace
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split" -- Real-time preview of substitution

-- Splits
opt.splitright = true -- Split vertical windows to the right
opt.splitbelow = true -- Split horizontal windows below

-- Completion Options (Crucial for nvim-cmp)
opt.completeopt = { "menuone", "noselect" }

-- Formatting
opt.list = true
