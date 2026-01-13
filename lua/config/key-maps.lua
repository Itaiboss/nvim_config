-- ~/.config/nvim/lua/config/key-maps.lua
-- Consolidated keybindings for all plugins and built-in features
local opts = { noremap = true, silent = true }

-- Set leader key (should match your vim-options.lua)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ===================================================================
-- BASIC VIM KEYBINDINGS
-- ===================================================================

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window Left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window Down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window Up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window Right" })

-- Resize windows with arrows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Resize Up" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Resize Down" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize Left" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize Right" })

-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "Previous Buffer" })

-- Clear search highlights
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear Highlights" })

-- Save and quit shortcuts
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", ":qa!<CR>", { desc = "Quit All Force" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent Left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent Right" })

-- Move text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Up" })

-- Keep cursor centered when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down Centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up Centered" })

-- Better paste (don't yank when pasting over)
vim.keymap.set("v", "p", '"_dP', { desc = "Paste Without Yank" })

vim.keymap.set("n", "<leader>??", function()
	print("Leader works! Current time: " .. os.date("%H:%M:%S"))
end, { desc = "Test Leader" })

-- ===================================================================
-- TELESCOPE (Fuzzy Finder)
-- ===================================================================

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>", { desc = "Colorschemes" })
vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", { desc = "Find String" })
vim.keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Marks" })
vim.keymap.set("n", "<leader>fR", "<cmd>Telescope registers<cr>", { desc = "Registers" })

-- ===================================================================
-- NVIM-TREE (File Explorer)
-- ===================================================================

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Tree" })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFocus<cr>", { desc = "Focus File Tree" })
vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<cr>", { desc = "Refresh File Tree" })
vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<cr>", { desc = "Collapse File Tree" })

-- ===================================================================
-- LAZYGIT
-- ===================================================================

vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
vim.keymap.set("n", "<leader>gl", "<cmd>LazyGitFilter<cr>", { desc = "LazyGit Log" })
vim.keymap.set("n", "<leader>gc", "<cmd>LazyGitFilterCurrentFile<cr>", { desc = "LazyGit Current File" })
vim.keymap.set("n", "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", { desc = "LazyGit File History" })

-- ===================================================================
-- TOGGLETERM (Terminal)
-- ===================================================================

-- These are fine to keep as global Normal mode mappings
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })
vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float Terminal" })
vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Horizontal Terminal" })
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Vertical Terminal" })

-- Better Terminal Navigation (Replaces your old 't' mappings)
local function set_terminal_keymaps()
	local opts = { buffer = 0 }
	-- Use 'jk' or <Esc> to get back to Normal mode inside the terminal
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)

	-- Navigation keys
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

-- This ensures the keys above only exist when you are actually IN a terminal
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*",
	callback = function()
		set_terminal_keymaps()
	end,
})

-- ===================================================================
-- PYTHON VENV SELECTOR
-- ===================================================================

vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>", { desc = "Select Python Venv" })
vim.keymap.set("n", "<leader>vc", "<cmd>VenvSelectCached<cr>", { desc = "Select Cached Venv" })

-- ===================================================================
-- LSP KEYBINDINGS (Applied when LSP attaches to buffer)
-- ===================================================================

-- These will be set up by the LSP on_attach function in mason.lua
-- But we can define them here for reference/documentation

local function setup_lsp_keymaps(bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	-- Go to
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", bufopts, { desc = "Go to Declaration" }))
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", bufopts, { desc = "Go to Definition" }))
	vim.keymap.set(
		"n",
		"gi",
		vim.lsp.buf.implementation,
		vim.tbl_extend("force", bufopts, { desc = "Go to Implementation" })
	)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", bufopts, { desc = "Go to References" }))
	vim.keymap.set(
		"n",
		"<leader>D",
		vim.lsp.buf.type_definition,
		vim.tbl_extend("force", bufopts, { desc = "Type Definition" })
	)

	-- Hover and help
	vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", bufopts, { desc = "Hover Documentation" }))
	vim.keymap.set(
		"n",
		"<C-k>",
		vim.lsp.buf.signature_help,
		vim.tbl_extend("force", bufopts, { desc = "Signature Help" })
	)

	-- Actions
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", bufopts, { desc = "Rename" }))
	vim.keymap.set(
		"n",
		"<leader>ca",
		vim.lsp.buf.code_action,
		vim.tbl_extend("force", bufopts, { desc = "Code Action" })
	)
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, vim.tbl_extend("force", bufopts, { desc = "Format" }))

	-- Workspace
	vim.keymap.set(
		"n",
		"<leader>wa",
		vim.lsp.buf.add_workspace_folder,
		vim.tbl_extend("force", bufopts, { desc = "Add Workspace Folder" })
	)
	vim.keymap.set(
		"n",
		"<leader>wr",
		vim.lsp.buf.remove_workspace_folder,
		vim.tbl_extend("force", bufopts, { desc = "Remove Workspace Folder" })
	)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, vim.tbl_extend("force", bufopts, { desc = "List Workspace Folders" }))

	-- Diagnostics
	vim.keymap.set(
		"n",
		"<leader>e",
		vim.diagnostic.open_float,
		vim.tbl_extend("force", bufopts, { desc = "Show Diagnostic" })
	)
	vim.keymap.set(
		"n",
		"[d",
		vim.diagnostic.goto_prev,
		vim.tbl_extend("force", bufopts, { desc = "Previous Diagnostic" })
	)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", bufopts, { desc = "Next Diagnostic" }))
	vim.keymap.set(
		"n",
		"<leader>q",
		vim.diagnostic.setloclist,
		vim.tbl_extend("force", bufopts, { desc = "Diagnostic List" })
	)

	-- LSP info and management
	vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", vim.tbl_extend("force", bufopts, { desc = "LSP Info" }))
	vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<cr>", vim.tbl_extend("force", bufopts, { desc = "LSP Restart" }))
	vim.keymap.set("n", "<leader>ls", "<cmd>LspStart<cr>", vim.tbl_extend("force", bufopts, { desc = "LSP Start" }))
	vim.keymap.set("n", "<leader>lS", "<cmd>LspStop<cr>", vim.tbl_extend("force", bufopts, { desc = "LSP Stop" }))
end

-- Export the LSP keymaps function so mason.lua can use it
_G.setup_lsp_keymaps = setup_lsp_keymaps

-- ===================================================================
-- VIMTEX (LaTeX)
-- ===================================================================

-- VimTeX keybindings are mostly set by the plugin
-- Main ones to know:
-- <localleader>ll - Start/Stop compilation
-- <localleader>lv - View PDF
-- <localleader>lc - Clean auxiliary files
-- <localleader>le - Show errors
-- <localleader>lt - Table of contents
--

-- ===================================================================
-- PLATFORMIO
-- ===================================================================
-- This opens the PlatformIO menu
vim.keymap.set("n", "<leader>p", "<cmd>Pioinit<cr>", { desc = "PlatformIO Menu" })
-- You can also add specific commands if you use them often:
vim.keymap.set("n", "<leader>pr", "<cmd>Piorun<cr>", { desc = "PlatformIO Run" })
vim.keymap.set("n", "<leader>pm", "<cmd>Piomon<cr>", { desc = "PlatformIO Monitor" })

return {
	setup_lsp_keymaps = setup_lsp_keymaps,
}
