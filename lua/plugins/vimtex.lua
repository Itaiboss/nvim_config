return {
	"lervag/vimtex",
	lazy = false,
	config = function()
		vim.g.vimtex_view_method = "skim"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_quickfix_mode = 0

		-- Essential for snippets: disable VimTeX's default insert mode mappings
		-- if they conflict with your snippets
		vim.g.vimtex_imaps_enabled = 0

		-- Recommended: Map localleader for VimTeX commands
	end,
}
