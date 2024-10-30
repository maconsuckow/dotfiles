return {
  "telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      config = function()
        require("telescope").load_extension("live_grep_args")
      end,
    },
  },
  keys = {
    {
      "<leader>fs",
      ':lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>',
      desc = "Grep (with args)",
    },
  },
}
