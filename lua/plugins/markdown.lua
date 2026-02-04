local preview_delay = 50

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "copilot-chat" },
      heading = {
        sign = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      pipe_table = {
        enabled = true,
      },
    },
    ft = { "markdown", "copilot-chat" },
  },
  {
    "iamcco/markdown-preview.nvim",
    keys = {
      { "<leader>cp", false },
      { "<leader>m", desc = "+markdown", mode = { "n", "v" } },
      {
        "<leader>mp",
        function()
          if vim.bo.filetype ~= "markdown" then
            print("Option only available in markdown files")
            return
          end

          vim.cmd("MarkdownPreviewStop")
          vim.defer_fn(function()
            vim.g.mkdp_markdown_css = vim.fn.stdpath("config") .. "/styles/standard.css"
            vim.cmd("MarkdownPreview")
          end, preview_delay)
        end,
        desc = "Preview Markdown",
      },
      {
        "<leader>mc",
        function()
          if vim.bo.filetype ~= "markdown" then
            print("Option only available in markdown files")
            return
          end

          vim.cmd("MarkdownPreviewStop")
          vim.defer_fn(function()
            vim.g.mkdp_markdown_css = vim.fn.stdpath("config") .. "/styles/cheatsheet.css"
            vim.cmd("MarkdownPreview")
          end, preview_delay)
        end,
        desc = "Preview Markdown as Cheat Sheet",
      },
    },
  },
}
