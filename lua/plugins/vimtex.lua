return {
  {
    "lervag/vimtex",
    lazy = true,
    ft = { "tex", "plaintex", "bib" },
    init = function()
      vim.g.vimtex_compiler_method = "tectonic"
    end,
  },
}
