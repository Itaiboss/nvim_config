-- stylua: ignore
vim.deprecate = function() end
local opt = vim.opt

-----------------------------------------------------------
-- General Behavior
-----------------------------------------------------------
opt.mouse = "a"                         -- Enable mouse support
opt.undofile = true                    -- Persistent undo history
opt.updatetime = 250                   -- Faster response for LSP/Gitsigns
opt.timeoutlen = 300                   -- Faster key sequence completion
opt.clipboard = "unnamedplus"          -- Sync with system clipboard
opt.backspace = "indent,eol,start"     -- Better backspace behavior
opt.iskeyword:append("-")              -- Treat dash-separated words as one word

-----------------------------------------------------------
-- Indenting & Tabs
-----------------------------------------------------------
opt.expandtab = true                   -- Use spaces instead of tabs
opt.shiftwidth = 4                     -- Size of an indent
opt.smartindent = true                 -- Insert indents automatically
opt.tabstop = 4                        -- Number of spaces tabs count for
opt.softtabstop = 4                    -- Number of spaces for a tab while editing
opt.breakindent = true                 -- Wrapped lines keep indentation

-----------------------------------------------------------
-- UI / Appearance
-----------------------------------------------------------
opt.number = true                      -- Show absolute line number
opt.relativenumber = true              -- Show relative line number
opt.termguicolors = true               -- True color support
opt.signcolumn = "yes"                 -- Always show signcolumn (prevents jumping)
opt.cursorline = true                  -- Highlight the current line
opt.scrolloff = 10                     -- Keep lines above/below cursor
opt.laststatus = 3                     -- Global statusline
opt.fillchars = { eob = " " }          -- Hide '~' on empty lines at end of buffer
opt.wrap = true                       -- Disable line wrapping

-----------------------------------------------------------
-- Search
-----------------------------------------------------------
opt.ignorecase = true                  -- Ignore case in search patterns
opt.smartcase = true                   -- Smart case sensing
opt.inccommand = "split"               -- Live preview of search and replace

-----------------------------------------------------------
-- Windows & Completion
-----------------------------------------------------------
opt.splitright = true                  -- Vertical splits to the right
opt.splitbelow = true                  -- Horizontal splits to the bottom
opt.completeopt = { "menuone", "noselect" } -- Crucial for nvim-cmp
opt.list = true                        -- Show some invisible characters
