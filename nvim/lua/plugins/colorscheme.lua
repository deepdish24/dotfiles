return {
  -- tell LazyVim what to load on startup
  { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } },

  -- set the flavour
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = { flavour = "frappe" },
  },
}
