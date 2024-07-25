return {
    {
        'williamboman/mason.nvim',
        opts = {
            ui = {
                icons = {
                    package_installed = "o",
                    package_pending = ">",
                    package_uninstalled = "x"
                }
            }
        }
    },
    {
        'williamboman/mason-lspconfig.nvim',
        opts = {
            ensure_installed = { "lua_ls", "rust_analyzer", "svelte", "tsserver" }
        }
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        opts = {},
        config = function(_, opts)
            local lsp_zero = require('lsp-zero')
            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr, preserve_mappings = false })
            end)
        end
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            "VonHeikemen/lsp-zero.nvim",
        },
        config = function(plugin, opts)
            local lspconfig = require('lspconfig')
            vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
            vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

            local border = {
                { "", "FloatBorder" },
                { "", "FloatBorder" },
                { "", "FloatBorder" },
                { "", "FloatBorder" },
                { "", "FloatBorder" },
                { "", "FloatBorder" },
                { "", "FloatBorder" },
                { "", "FloatBorder" },
            }

            local handlers = {
                ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
                ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
            }

            lspconfig.tsserver.setup {}
            lspconfig.svelte.setup {}
            lspconfig.rust_analyzer.setup {
                settings = {
                    ['rust-analyzer'] = {
                        diagnostics = {
                            enable = false,
                        }
                    }
                },
                handlers = handlers
            }
            lspconfig.lua_ls.setup({
                on_init = function(client)
                    local path = client.workspace_folders[1].name
                    if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                        return
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            -- Tell the language server which version of Lua you're using
                            -- (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT'
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME
                                -- Depending on the usage, you might want to add additional paths here.
                                -- "${3rd}/luv/library"
                                -- "${3rd}/busted/library",
                            }
                            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                            -- library = vim.api.nvim_get_runtime_file("", true)
                        }
                    })
                end,
                settings = {
                    Lua = {}
                }
            })
        end
    },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
}
