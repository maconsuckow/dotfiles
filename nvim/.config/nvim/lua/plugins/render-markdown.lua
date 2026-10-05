return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown" },
  opts = {
    latex = { enabled = false },
    code = {
      -- Change this to 'none' to disable the background bar
      style = "none",
      -- Alternatively, you can disable just the width expansion
      width = "block",
    },
  },
}
