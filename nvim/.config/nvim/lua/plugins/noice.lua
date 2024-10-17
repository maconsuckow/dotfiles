return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    routes = {
      {
        filter = { event = "notify", find = "No information available" },
        opts = { skip = true },
      },
      {
        view = "notify",
        filter = { event = "msg_showmode" },
      },
    },
    presets = {
      lsp_doc_border = true,
    },
    command_palette = true,
    lsp_doc_border = true,
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
}
