local vault = "/mnt/c/Users/yihao/OneDrive - National University of Singapore/school/y2s2/"
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
      latex = {
        enabled = false,
      },
      overrides = {
        preview = {
          latex = { enabled = true },
        },
      },
    },
    ft = { "markdown", "copilot-chat" },
    keys = {
      { "<leader>mi", "<cmd>RenderMarkdown preview<cr>", desc = "Preview Markdown in editor", ft = "markdown" },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    ft = "markdown",
    init = function()
      vim.g.mkdp_page_title = "${name}"
      vim.g.mkdp_preview_options = {
        disable_filename = 1,
      }
    end,
    keys = {
      { "<leader>cp", false },
      { "<leader>m", desc = "+markdown", mode = { "n", "v" }, ft = "markdown" },
      {
        "<leader>mp",
        function()
          vim.cmd("MarkdownPreviewStop")
          vim.defer_fn(function()
            vim.g.mkdp_markdown_css = vim.fn.stdpath("config") .. "/styles/standard.css"
            vim.cmd("MarkdownPreview")
          end, preview_delay)
        end,
        desc = "Preview Markdown",
        ft = "markdown",
      },
      {
        "<leader>mc",
        function()
          vim.cmd("MarkdownPreviewStop")
          vim.defer_fn(function()
            vim.g.mkdp_markdown_css = vim.fn.stdpath("config") .. "/styles/cheatsheet.css"
            vim.cmd("MarkdownPreview")
          end, preview_delay)
        end,
        desc = "Preview Markdown as Cheat Sheet",
        ft = "markdown",
      },
    },
  },
  {
    "obsidian-nvim/obsidian.nvim",
    lazy = true,
    ft = { "markdown" },
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      legacy_commands = false, -- this will be removed in the next major release
      ui = { enable = false },
      workspaces = {
        {
          name = "school",
          path = vault,
        },
      },
    },
  },
}
