return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = { "lua", "rust", "svelte", "bash" },
            highlight = {
                enable = true,
                disable = false,
            }
        },
        config = function(plugin, opts)
            require('nvim-treesitter.configs').setup(opts)
        end
    }
}
