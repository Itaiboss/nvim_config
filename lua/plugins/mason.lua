-- Complete Mason + LSP + Linters configuration
-- Place this in ~/.config/nvim/lua/plugins/lsp.lua (or wherever your mason config is)

return {
    -- Mason: Package manager for LSP servers, linters, formatters
    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        }
    },

    -- Mason-lspconfig: Bridges mason and lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            -- LSP servers to auto-install
            ensure_installed = {
                "lua_ls",        -- Lua
                "rust_analyzer", -- Rust
                "clangd",        -- C/C++
                "pylsp",         -- Python (python-lsp-server)
            },
            automatic_installation = true,
            -- Don't auto-configure servers, we'll do it manually
            handlers = {
                -- Default handler (optional)
                function(server_name)
                    -- Only configure servers we explicitly set up
                    if server_name ~= "pyright" then
                        -- Will be configured in nvim-lspconfig section
                    end
                end,
            },
        }
    },

    -- Mason-null-ls: Auto-install linters & formatters
    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        opts = {
            ensure_installed = {
                -- C/C++
                ---"clang-format",  -- Formatter
                "cpplint",       -- Linter
                
                -- Python
                "black",         -- Formatter
                "isort",         -- Import sorter
               
                "flake8",        -- Linter
                
                -- Lua
                "stylua",        -- Formatter
                "luacheck",      -- Linter
                
                -- General
                "codespell",     -- Spell checker
            },
            automatic_installation = true,
        }
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
                    null_ls.builtins.formatting.clang_format,
                    null_ls.builtins.diagnostics.cpplint,
                    
                    -- Python
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.diagnostics.pylint,
                    null_ls.builtins.diagnostics.flake8,
                    
                    -- Lua
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.diagnostics.luacheck,
                    
                    -- General
                    null_ls.builtins.diagnostics.codespell,
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
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- Common on_attach function
            local on_attach = function(client, bufnr)
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                
                -- Keybindings
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
                vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
                vim.keymap.set('n', '<space>f', function()
                    vim.lsp.buf.format { async = true }
                end, bufopts)
                vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, bufopts)
                vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
                vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
            end

            -- C/C++ - clangd
            vim.lsp.config.clangd = {
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                },
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
                root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", ".git" },
                capabilities = capabilities,
                on_attach = on_attach,
            }

            -- Python - pylsp (python-lsp-server)
            -- Determine which pylsp to use (venv or system)
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

            vim.lsp.config.pylsp = {
                cmd = get_pylsp_cmd(),
                filetypes = { "python" },
                root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    pylsp = {
                        plugins = {
                            -- Linting
                            pylint = { enabled = true, executable = "pylint" },
                            pyflakes = { enabled = false },
                            pycodestyle = { enabled = false },
                            -- Type checking
                            pylsp_mypy = { enabled = false },
                            -- Auto-completion
                            jedi_completion = { 
                                enabled = true,
                                fuzzy = true,
                            },
                            jedi_hover = { enabled = true },
                            jedi_references = { enabled = true },
                            jedi_signature_help = { enabled = true },
                            jedi_symbols = { enabled = true, all_scopes = true },
                            -- Formatting (handled by null-ls)
                            autopep8 = { enabled = false },
                            yapf = { enabled = false },
                        }
                    }
                },
            }

            -- Rust - rust-analyzer
            vim.lsp.config.rust_analyzer = {
                cmd = { "rust-analyzer" },
                filetypes = { "rust" },
                root_markers = { "Cargo.toml", ".git" },
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
            }

            -- Lua - lua_ls
            vim.lsp.config.lua_ls = {
                cmd = { "lua-language-server" },
                filetypes = { "lua" },
                root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", ".git" },
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        diagnostics = { globals = { 'vim' } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            }

            -- Enable LSP servers
            vim.lsp.enable({ "clangd", "pylsp", "rust_analyzer", "lua_ls" })

            -- Diagnostic configuration
            vim.diagnostic.config({
                virtual_text = {
                    prefix = '●',
                    source = "if_many",
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "✘",
                        [vim.diagnostic.severity.WARN] = "▲",
                        [vim.diagnostic.severity.HINT] = "⚑",
                        [vim.diagnostic.severity.INFO] = "»",
                    },
                },
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = "always",
                },
            })

            -- Hover borders
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                vim.lsp.handlers.hover, { border = "rounded" }
            )
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers.signature_help, { border = "rounded" }
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
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                }, {
                    { name = 'buffer' },
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
        end
    },
}
