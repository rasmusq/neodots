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
                { "<leader>ff", "<cmd>FzfLua files<cr>",        desc = "find", mode = "n" },
                { "<leader>fg", "<cmd>FzfLua grep_project<cr>", desc = "grep", mode = "n" },
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
