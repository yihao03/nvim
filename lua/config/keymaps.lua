-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>gl", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle Git Blame" })

vim.api.nvim_create_user_command("DisableCopilot", "lsp stop copilot", {})
vim.api.nvim_create_user_command("EnableCopilot", "lsp enable copilot", {})
