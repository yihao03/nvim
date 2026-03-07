return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = {
      styles = {
        transparency = true,
      },

      -- for use with FiraCode iScript
      highlight_groups = {
        ["@variable"] = { italic = false },
        ["@property"] = { italic = false },
        ["@module.go"] = { italic = true },
        Keyword = { italic = true },
        String = { italic = true },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
