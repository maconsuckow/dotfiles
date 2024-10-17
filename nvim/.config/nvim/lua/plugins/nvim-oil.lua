return {
  "stevearc/oil.nvim",
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  keys = {
    { "<leader>=", "<cmd>Oil<cr>", mode = "n", desc = "Open Filesystem" },
    { "<leader>-", "<cmd>Oil --float<cr>", mode = "n", desc = "Open Floating Filesystem" },
  },
  opts = {
    delete_to_trash = true,
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 10,
      preview_split = "right",
    },
  },
}