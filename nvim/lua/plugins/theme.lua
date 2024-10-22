return {
    {
        "Shatur/neovim-ayu",
        opts = {
        },
        config = function(plugin, opts)
            require('ayu').setup({
                overrides = {
                    Normal = { bg = "None" },
                    ColorColumn = { bg = "None" },
                    SignColumn = { bg = "None" },
                    Folded = { bg = "None" },
                    FoldColumn = { bg = "None" },
                    CursorLine = { bg = "None" },
                    CursorColumn = { bg = "None" },
                    WhichKeyFloat = { bg = "None" },
                    VertSplit = { bg = "None" },
                }
            })
        end
    },
    { "EdenEast/nightfox.nvim" },
    { "p00f/alabaster.nvim" },
    {
        "f-person/auto-dark-mode.nvim",
        opts = {
            update_interval = 1000,
            set_dark_mode = function()
                vim.api.nvim_set_option("background", "dark")
                vim.cmd("colorscheme ayu-dark")
                -- vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
            end,
            set_light_mode = function()
                vim.api.nvim_set_option("background", "light")
                vim.cmd("colorscheme ayu-light")
                -- vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
            end,
        }
    },
}
