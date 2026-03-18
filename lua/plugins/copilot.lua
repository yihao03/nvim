return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken",
    opts = {
      sticky = "#buffer",
      model = "gpt-5.3-codex",
      highlight_headers = false,
      headers = {
        user = "  ",
        assistant = "  ",
      },
      separator = "---",
      window = {
        width = 0.3,
      },
      -- insert_at_end = true,
      stop_function_on_failure = true,
    },
  },
}
