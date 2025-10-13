return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      copilot_node_command = "/home/yihao/.nvm/versions/node/v24.4.1/bin/node",
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken",
    opts = {
      sticky = "@copilot",
      model = "claude-sonnet-4.5",
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
    -- See Commands section for default commands if you want to lazy load on them
  },
}
