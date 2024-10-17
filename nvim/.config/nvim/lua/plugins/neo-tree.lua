return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = false,
  keys = {
    {
      "<leader>be",
      function()
        require("neo-tree.command").execute({
          source = "buffers",
          toggle = true,
          dir = vim.uv.cwd(),
          reveal = true,
          position = "left",
        })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
  },
  opts = {
    popup_border_style = "rounded",
    filesystem = {
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          -- '.git'
          -- '.DS_Store'
        },
        never_show = {},
      },
      follow_current_file = {
        enabled = true,
      },
    },
  },
}
