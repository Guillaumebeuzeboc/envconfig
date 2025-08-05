return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim", opts = { terminal_colors = false } },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
