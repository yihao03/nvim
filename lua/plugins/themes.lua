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
        -- DiagnosticUnderlineError = { underline = true, undercurl = false },
        -- DiagnosticUnderlineHint = { underline = true, undercurl = false },
        -- DiagnosticUnderlineInfo = { underline = true, undercurl = false },
        -- DiagnosticUnderlineWarn = { underline = true, undercurl = false },
        -- SpellBad = { underline = true, undercurl = false },
        -- SpellCap = { underline = true, undercurl = false },
        -- SpellLocal = { underline = true, undercurl = false },
        -- SpellRare = { underline = true, undercurl = false },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine-moon",
    },
  },
}
