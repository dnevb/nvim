return {
  {
    "rose-pine/neovim",
    config = function()
      require("rose-pine").setup({
        styles = {
          transparency = true,
        },
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = { sidebars = "transparent", floats = "transparent" },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-moon",
    },
  },
}
