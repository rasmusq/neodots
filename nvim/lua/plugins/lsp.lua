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
            ensure_installed = { "lua_ls", "rust_analyzer", "svelte", "ts_ls", "hyprls" }
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
            local lspconfig_defaults = lspconfig.util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }
                    local wk = require("which-key")
                    wk.add({

                        { "gh", "<cmd>lua vim.lsp.buf.hover()<cr>",                desc = "hover",            mode = "n" },
                        { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>",           desc = "definitions",      mode = "n" },
                        { "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>",          desc = "declarations",     mode = "n" },
                        { "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>",       desc = "implementations",  mode = "n" },
                        { "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>",      desc = "type definitions", mode = "n" },
                        { "gr", "<cmd>lua vim.lsp.buf.type_references()<cr>",      desc = "references",       mode = "n" },
                        { "gr", "<cmd>lua vim.lsp.buf.type_signature_help()<cr>",  desc = "signature help",   mode = "n" },
                        { "gR", "<cmd>lua vim.lsp.buf.rename()<cr>",               desc = "rename",           mode = "n" },
                        { "gF", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", desc = "format",           mode = "n" },
                        { "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>",          desc = "code action",      mode = "n" },
                    })
                end,
            })

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

            lspconfig.ts_ls.setup {}
            lspconfig.csharp_ls.setup {}
            lspconfig.hyprls.setup {}
            -- Hyprlang LSP
            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
                pattern = { "*.hl", "hypr*.conf" },
                callback = function(event)
                    print(string.format("starting hyprls for %s", vim.inspect(event)))
                    vim.lsp.start {
                        name = "hyprlang",
                        cmd = { "hyprls" },
                        root_dir = vim.fn.getcwd(),
                    }
                end
            })
            lspconfig.pyright.setup {}
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
    {
        'hrsh7th/nvim-cmp',
        config = function(plugin, opts)
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    -- ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end
    },
    { 'L3MON4D3/LuaSnip' },
}
