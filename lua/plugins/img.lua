return {
  "HakonHarnes/img-clip.nvim",
  lazy = true,
  opts = {
    filetypes = {
      markdown = {
        template = "![$FILE_NAME_NO_EXT]($FILE_PATH)",
      },
    },
  },
  keys = {
    { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard", ft = "markdown" },
  },
  ft = { "markdown", "tex" },
}
