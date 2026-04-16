return {
  "obsidian-nvim/obsidian.nvim",
  lazy = true,
  ft = { "markdown" },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in the next major release
    workspaces = {
      {
        name = "school",
        path = "/mnt/c/Users/yihao/OneDrive - National University of Singapore/school/y2s2/",
      },
    },
  },
}
