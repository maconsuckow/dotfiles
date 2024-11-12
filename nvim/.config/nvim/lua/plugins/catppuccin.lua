return {
  {
    "catppuccin/nvim",
    lazy = true,
    enabled = false,
    priority = 1000,
    opts = {
      flavour = "frappe",
      transparent_background = true,
    },
    integrations = {
      notify = true,
      noice = true,
      neotree = true,
      which_key = true,
    },
  },
}
