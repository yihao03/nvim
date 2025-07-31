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
    version = "3.12.2",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken",
    opts = {
      model = "o4-mini",
      headers = {
        user = " ",
        assistant = "  Copilot",
      },
      window = {
        width = 0.3,
      },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
