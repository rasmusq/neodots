return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = { "lua", "rust", "svelte", "bash", "hyprlang" },
            highlight = {
                enable = true,
                disable = false,
            }
        },
        config = function(plugin, opts)
            require('nvim-treesitter.configs').setup(opts)
        end
    },
    {
        "luckasRanarison/tree-sitter-hyprlang",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function(plugin, opts)
            vim.filetype.add({
                pattern = { [".*/hyprland%.conf"] = "hyprlang" },
            })
        end
    }
}
