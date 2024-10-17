return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      html = { "prettier" },
      typescript = { "prettier" },
      yaml = { "prettier" },
    },
    formatters = {
      prettier = {
        semi = false,
        singleQuote = true,
        trailingComma = "es5",
        endOfLine = "auto",
      },
    },
  },
}
