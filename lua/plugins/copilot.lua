return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "BufReadPost",
  opts = {
    copilot_node_command = "/home/yihao/.nodenv/versions/24.1.0/bin/node",
  },
}
