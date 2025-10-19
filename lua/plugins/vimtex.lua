return {
    "lervag/vimtex",
    lazy = false,
    config = function()
        -- Use Skim as the PDF viewer on macOS
        vim.g.vimtex_view_method = 'skim'
        
        -- Compiler method (latexmk is default and recommended)
        vim.g.vimtex_compiler_method = 'latexmk'
        
        -- Set local leader
--        vim.g.maplocalleader = ","
        
        -- Don't auto-open quickfix window
        vim.g.vimtex_quickfix_mode = 0
    end,
}
