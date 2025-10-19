-- Python virtual environment selector for pyenv
-- Place this in ~/.config/nvim/lua/plugins/venv-selector.lua

return {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-telescope/telescope.nvim",
        "mfussenegger/nvim-dap-python",
    },
    branch = "regexp",  -- Use the regexp branch for better pyenv support
    config = function()
        require("venv-selector").setup({
            -- Automatically search for pyenv virtualenvs
            search_venv_managers = true,
            search_workspace = true,
            pyenv_path = vim.fn.expand("~/.pyenv/versions"),
            
            -- Auto-select venv when opening Python files
            auto_refresh = true,
            
            -- Show notification when venv is activated
            notify_user_on_activate = true,
        })
    end,
    keys = {
        -- Keybinding to manually select a venv
        { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
        { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select Cached VirtualEnv" },
    },
}
