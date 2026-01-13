return {
	"nvim-tree/nvim-tree.lua",
	version = "*", -- optional, can pin to latest stable
	lazy = false, -- load on startup (set true to lazy-load)
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- for icons
	config = function()
		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			view = {
				width = 30,
				side = "left",
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = false,
			},
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = true,
			},
		})

		-- optional keybinds
	end,
}
