local icons = LazyVim.config.icons
local date = os.date()
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "yavorski/lualine-macro-recording.nvim" },
  opts = {
    options = {
      theme = "catppuccin",
      section_separators = { right = "", left = "" },
      disabled_filetypes = { statusline = { "dashboard", "Neo-tree" } },
    },
    sections = {
      lualine_a = {
        { "mode", separator = { left = "", right = "" }, right_padding = 2 },
      },
      lualine_b = {
        { "branch", separator = { right = "" } },
        { "diff", separator = { left = "", right = "" }, symbols = { added = "+", modified = "~", removed = "-" } },
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
          colored = false,
          separator = { left = "", right = "" },
        },
      },
      lualine_c = {
        LazyVim.lualine.pretty_path({ relative = "root" }),
        { "macro_recording" },
      },
      lualine_x = {
        { "searchcount", separator = { left = "" }, right_padding = 2 },
        {
          function()
            return require("noice").api.status.command.get()
          end,
          cond = function()
            return package.loaded["noice"] and require("noice").api.status.command.has()
          end,
          color = function()
            return LazyVim.ui.fg("Statement")
          end,
        },
        LazyVim.lualine.cmp_source("codeium"),
          -- stylua: ignore
        {
        function() return require("noice").api.status.mode.get() end,
        cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
        color = function() return LazyVim.ui.fg("Constant") end,
        },
        -- stylua: ignore
        {
        function() return "  " .. require("dap").status() end,
        cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
        color = function() return LazyVim.ui.fg("Debug") end,
        },
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = function()
            return LazyVim.ui.fg("Special")
          end,
        },
      },
      lualine_y = { { "progress", separator = { left = "" } } },
      lualine_z = {
        { "location", separator = { left = "" } },
        { "os.date('%a %b %d %I:%M %p')", separator = { right = "" }, left_padding = 2 },
      },
    },
  },
}
