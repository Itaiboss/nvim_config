-- ~/.config/nvim/lua/plugins/mason.lua
-- Complete Mason + LSP + Linters configuration

return {
    -- Mason: Package manager for LSP servers, linters, formatters
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

    -- Mason-lspconfig: Bridges mason and lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",        -- Lua
                    "clangd",        -- C/C++
                    "pylsp",         -- Python
                    "rust_analyzer", -- Rust (if you use it)
                },
                automatic_installation = true,
            })
        end
    },

    -- Mason-null-ls: Auto-install linters & formatters
    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = {
                    -- C/C++
                    "clang-format",  -- Formatter
                    "cpplint",       -- Linter
                    
                    -- Python
                    "black",         -- Formatter
                    "isort",         -- Import sorter
                    "flake8",        -- Linter
                    
                    -- Lua
                    "stylua",        -- Formatter
                    "luacheck",      -- Linter
                },
                automatic_installation = true,
            })
        end
    },

    -- None-ls: Integrate linters/formatters with LSP
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            
            null_ls.setup({
                sources = {
                    -- C/C++
                    null_ls.builtins.formatting.clang_format.with({
                        extra_args = { "--style=Google" }, -- Change to your preferred style
                    }),
                    null_ls.builtins.diagnostics.cpplint,
                    
                    -- Python
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.diagnostics.flake8,
                    
                    -- Lua
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.diagnostics.luacheck,
                },
                -- Format on save
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

    -- LSP Configuration
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

            -- Common on_attach function with keybindings
            local on_attach = function(client, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }
                
                -- LSP Keybindings
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', '<space>f', function()
                    vim.lsp.buf.format { async = true }
                end, opts)
                vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
                vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
                vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
                vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

                -- Inlay hints (if supported)
                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end
            end

            -- C/C++ - clangd with advanced features
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
                    "--offset-encoding=utf-16",  -- Add this to fix encoding warning
                },
                capabilities = capabilities,
                on_attach = on_attach,
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
                root_dir = lspconfig.util.root_pattern(
                    '.clangd',
                    '.clang-tidy',
                    '.clang-format',
                    'compile_commands.json',
                    'compile_flags.txt',
                    'configure.ac',
                    '.git'
                ),
            })

            -- Python - pylsp
            local function get_pylsp_cmd()
                local venv = os.getenv("VIRTUAL_ENV")
                if venv then
                    local venv_pylsp = venv .. "/bin/pylsp"
                    if vim.fn.executable(venv_pylsp) == 1 then
                        return { venv_pylsp }
                    end
                end
                return { "pylsp" }
            end

            lspconfig.pylsp.setup({
                cmd = get_pylsp_cmd(),
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    pylsp = {
                        plugins = {
                            pyflakes = { enabled = false },
                            pycodestyle = { enabled = false },
                            jedi_completion = { 
                                enabled = true,
                                fuzzy = true,
                            },
                            jedi_hover = { enabled = true },
                            jedi_references = { enabled = true },
                            jedi_signature_help = { enabled = true },
                            jedi_symbols = { enabled = true, all_scopes = true },
                        }
                    }
                },
            })

            -- Lua - lua_ls
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        diagnostics = { 
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                        hint = {
                            enable = true,
                        },
                    },
                },
            })

            -- Rust (optional)
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    ['rust-analyzer'] = {
                        checkOnSave = {
                            command = "clippy",
                        },
                        cargo = {
                            allFeatures = true,
                        },
                        procMacro = {
                            enable = true,
                        },
                    }
                },
            })

            -- Diagnostic configuration
            vim.diagnostic.config({
                virtual_text = {
                    prefix = '●',
                    source = "if_many",
                },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })

            -- Diagnostic signs
            local signs = {
                Error = "✘",
                Warn = "▲",
                Hint = "⚑",
                Info = "»",
            }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            -- Hover and signature help borders
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                vim.lsp.handlers.hover,
                { border = "rounded" }
            )
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers.signature_help,
                { border = "rounded" }
            )
        end
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp', priority = 1000 },
                    { name = 'luasnip', priority = 750 },
                    { name = 'path', priority = 500 },
                }, {
                    { name = 'buffer', priority = 250 },
                }),
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snippet]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                        })[entry.source.name]
                        return vim_item
                    end
                },
            })

            -- Cmdline completions
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end
    },
}
