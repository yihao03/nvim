return {
  {
    "coder/claudecode.nvim",
    opts = {},
    keys = {
      -- disable default keymaps
      { "<leader>a", false },
      { "<leader>ac", false },
      { "<leader>af", false },
      { "<leader>ar", false },
      { "<leader>aC", false },
      { "<leader>ab", false },
      { "<leader>as", false },
      { "<leader>as", false },
      -- Diff management
      { "<leader>aa", false },
      { "<leader>ad", false },
      -- Use <leader>h for Claude (easy to type and remember)
      { "<leader>h", "", desc = "+claude", mode = { "n", "v" } },
      { "<leader>hh", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>hf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>hr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>hC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>hb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>hs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>hs",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil" },
      },
      -- Diff management
      { "<leader>ha", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>hd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
}
