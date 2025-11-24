return {
  {
    "iamcco/markdown-preview.nvim",
    keys = {
      {
        "<leader>mc",
        function()
          if vim.bo.filetype ~= "markdown" then
            print("Option only available in markdown files")
            return
          end

          if vim.g.mkdp_markdown_css:match("cheatsheet") then
            vim.g.mkdp_markdown_css = vim.fn.stdpath("config") .. "/styles/standard.css"
            print("Switched to standard styling")
          else
            vim.g.mkdp_markdown_css = vim.fn.stdpath("config") .. "/styles/cheatsheet.css"
            print("Switched to cheatsheet styling")
          end
          -- Restart preview to apply new CSS
          vim.cmd("MarkdownPreviewStop")
          vim.cmd("MarkdownPreview")
        end,
        desc = "Toggle Markdown CSS Style",
      },
    },
  },
}
