-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>gl", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle Git Blame" })

vim.api.nvim_create_user_command("DisableCopilot", "lsp stop copilot", {})
vim.api.nvim_create_user_command("EnableCopilot", "lsp enable copilot", {})

vim.keymap.set("n", "<C-l>", function()
  local ns = vim.api.nvim_create_namespace("nvim.multicursor")
  if #vim.api.nvim_buf_get_extmarks(0, ns, 0, -1, { limit = 1 }) > 0 then
    vim.cmd("nohlsearch | diffupdate")
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
  else
    vim.cmd("wincmd l")
  end
end, { desc = "Clear multicursors / Go to Right Window" })
