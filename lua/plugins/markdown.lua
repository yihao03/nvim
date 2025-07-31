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
}
