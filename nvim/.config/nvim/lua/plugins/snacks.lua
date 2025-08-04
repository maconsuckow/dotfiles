return {
  "folke/snacks.nvim",
  lazy = false,
  keys = {
    {
      "<leader><space>",
      function()
        Snacks.picker.smart()
      end,
      desc = "Find Files",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command Hisotry",
    },
    {
      "<leader>e",
      function()
        Snacks.picker.explorer()
      end,
      desc = "Explorer",
    },
    {
      "<leader>n",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Notification History",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Open Buffers",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "[B]uffer [D]elete ",
    },
    {
      "<leader>bo",
      function()
        Snacks.bufdelete()
      end,
      desc = "[B]uffer Delete [O]thers",
    },
  },
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { section = "keys",       gap = 1,                  padding = 1 },
        { title = "Recent Files", section = "recent_files", indent = 2, padding = { 2, 1 } },
        { section = "startup" },
      },
    },
    explorer = {
      enabled = true,
      tree = false,
      focus = "input",
    },
    indent = { enabled = true },
    input = { enabled = true },
    picker = {
      enabled = true,
      sources = {
        explorer = {
          replace_netrw = true,
          layout = { preset = "default", preview = true },
          tree = false,
          focus = "list",
          auto_close = true,
          formatters = {
            file = {
              filename_first = true,
            },
          },
        },
      },
    },
    notify = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = false },
    scroll = { enabled = true, animate = { duration = { total = 100 } } },
    word = { enabled = false },
  },
  a,
}
