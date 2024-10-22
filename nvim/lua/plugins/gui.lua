return {
  { "nvim-lualine/lualine.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        bottom_search = true,
      },
      cmdline = {
        view = "cmdline",
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      return {
        default_component_configs = {
          indent = {
            indent_marker = " ",
            last_indent_marker = " ",
            expander_collapsed = "-",
            expander_expanded = ">",
          },
          icon = {
            folder_closed = "-",
            folder_open = ">",
            folder_empty = " ",
            provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
              if node.type == "file" or node.type == "terminal" then
                local success, web_devicons = pcall(require, "nvim-web-devicons")
                local name = node.type == "terminal" and "terminal" or node.name
                if success then
                  local devicon, hl = web_devicons.get_icon(name)
                  icon.text = (devicon or icon.text)
                  -- icon.text = ""
                  icon.highlight = hl or icon.highlight
                end
              end
            end,
          },
        },
      }
    end,
  },
}
