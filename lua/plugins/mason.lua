-- ~/.config/nvim/lua/plugins/mason.lua
local keymaps = require("config.key-maps")

return {
    -- 1. LazyDev: Specifically for Neovim Config development
    -- This fixes the "Undefined global vim" and adds Neovim API completion
    {
        "folke/lazydev.nvim",
        ft = "lua", 
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },

    -- 2. Mason: Package manager
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    },
                    border = "rounded",
                }
            })
        end
    },

    -- 3. Mason-lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "pylsp",
                    "rust_analyzer",
                },
                automatic_installation = true,
            })
        end
    },

    -- 4. Mason-null-ls
    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = {
                    "clang-format",
                    "cpplint",
                    "black",
                    "isort",
                    "flake8",
                    "stylua",
                    "luacheck", -- Note: This might still flag 'vim' unless you have a .luacheckrc
                },
                automatic_installation = true,
            })
        end
    },

    -- 5. LSP Configuration
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local on_attach = function(client, bufnr)
                keymaps.setup_lsp_keymaps(bufnr)
                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end
            end

            -- Clangd
            lspconfig.clangd.setup({
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                    "--pch-storage=memory",
                    "--offset-encoding=utf-16",
                },
                capabilities = capabilities,
                on_attach = on_attach,
            })

            -- Python
            lspconfig.pylsp.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    pylsp = {
                        plugins = {
                            pyflakes = { enabled = false },
                            pycodestyle = { enabled = false },
                        }
                    }
                },
            })

            -- Lua - Updated for compatibility with lazydev
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        diagnostics = {
                            globals = { 'vim' }, -- Fallback for non-lazydev environments
                        },
                        workspace = {
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            })
            
            -- Diagnostic appearance
            vim.diagnostic.config({
                virtual_text = { prefix = '●' },
                severity_sort = true,
                float = { border = "rounded" },
            })
        end
    },

    -- 6. None-ls
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.clang_format,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.stylua,
                    -- Note: if Luacheck still shows errors, create a .luacheckrc 
                    -- file in your project root with: globals = {"vim"}
                    null_ls.builtins.diagnostics.luacheck, 
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
            })
        end,
    },

    -- 7. Autocompletion (nvim-cmp)
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'buffer' },
                }),
            })
        end
    },
}
