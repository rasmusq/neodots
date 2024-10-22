return {
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local fzf = require("fzf-lua")
            fzf.setup({})
            local wk = require("which-key")
            wk.add({
                { "<leader>f",  group = "fzf-lua" }, -- group
                { "<leader>ff", "<cmd>FzfLua files<cr>",                     desc = "find",                  mode = "n" },
                { "<leader>fg", "<cmd>FzfLua grep_project<cr>",              desc = "grep",                  mode = "n" },
                { "<leader>fd", "<cmd>FzfLua lsp_definitions<cr>",           desc = "definitions",           mode = "n" },
                { "<leader>fD", "<CMD>FzfLua lsp_declarations<cr>",          desc = "declarations",          mode = "n" },
                { "<leader>fi", "<CMD>FzfLua lsp_implementations<cr>",       desc = "implementations",       mode = "n" },
                { "<leader>fo", "<CMD>FzfLua lsp_typedefs<cr>",              desc = "typedefs",              mode = "n" },
                { "<leader>fr", "<CMD>FzfLua lsp_references<cr>",            desc = "references",            mode = "n" },
                { "<leader>fs", "<CMD>FzfLua lsp_document_symbols<cr>",      desc = "document symbols",      mode = "n" },
                { "<leader>fS", "<CMD>FzfLua lsp_workspace_symbols<cr>",     desc = "workspace symbols",     mode = "n" },
                { "<leader>fa", "<CMD>FzfLua lsp_code_actions<cr>",          desc = "code actions",          mode = "n" },
                { "<leader>fe", "<CMD>FzfLua lsp_document_diagnostics<cr>",  desc = "document diagnostics",  mode = "n" },
                { "<leader>fE", "<CMD>FzfLua lsp_workspace_diagnostics<cr>", desc = "workspace diagnostics", mode = "n" },
                { "<leader>fh", "<CMD>FzfLua search_history<cr>",            desc = "search history",        mode = "n" },
                { "<leader>fH", "<CMD>FzfLua command_history<cr>",           desc = "command history",       mode = "n" },
                { "<leader>fR", "<CMD>FzfLua registers<cr>",                 desc = "registers",             mode = "n" },
                { "<leader>fG", "<CMD>FzfLua git_status<cr>",                desc = "git status",            mode = "n" },
            })
        end
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            icons = {
                separator = "|",
                mappings = false,
                keys = {
                    BS = "<BS>",
                    Esc = "<ESC>"
                }
            }
        },
        keys = {
            { "<leader>w", "<cmd>w<cr>",  desc = "save",       mode = "n" },
            { "<leader>q", "<cmd>q<cr>",  desc = "quit",       mode = "n" },
            { "<leader>Q", "<cmd>q!<cr>", desc = "force quit", mode = "n" },
        },
    }
}
