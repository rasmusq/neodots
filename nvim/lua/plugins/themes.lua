return {
  {
    "Shatur/neovim-ayu",
    opts = {},
    config = function(plugin, opts)
      local line_nr_hl = vim.api.nvim_get_hl(0, { name = "LineNr" })

      require("ayu").setup({
        overrides = {
          Normal = { bg = "None" },
          ColorColumn = { bg = "None" },
          SignColumn = { bg = "None" },
          CursorLineNr = { bg = "None" },
          LineNr = line_nr_hl,
          Folded = { bg = "None" },
          FoldColumn = { bg = "None" },
          CursorLine = { bg = "None" },
          CursorColumn = { bg = "None" },
          WhichKeyFloat = { bg = "None" },
          VertSplit = { bg = "None" },
          WinSeparator = { bg = "None" },
          Whitespace = line_nr_hl,
        },
      })
    end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.cmd("colorscheme ayu-dark")
      end,
      set_light_mode = function()
        vim.cmd("colorscheme ayu-light")
      end,
    },
  },
}
