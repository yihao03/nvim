-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.uv.os_setenv("JAVA_HOME", "/home/yihao/.sdkman/candidates/java/22.0.2-oracle/")

vim.g.mkdp_markdown_css = os.getenv("HOME") .. "/.config/nvim/styles/cheatsheet.css"
