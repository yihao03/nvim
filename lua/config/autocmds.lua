-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.uv.os_setenv("JAVA_HOME", "/home/yihao/.sdkman/candidates/java/22.0.2-oracle/")

local grp = vim.api.nvim_create_augroup("JavaIndent", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = grp,
  pattern = "java",
  callback = function(ev)
    local bo = vim.bo[ev.buf]
    bo.tabstop = 4
    bo.shiftwidth = 4
    bo.softtabstop = 4
    bo.expandtab = true
  end,
})

-- Remove LazyVim's default wrap behavior for markdown
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Markdown automatic line breaks
local md_grp = vim.api.nvim_create_augroup("MarkdownLineBreaks", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = md_grp,
  pattern = "markdown",
  callback = function(ev)
    local bo = vim.bo[ev.buf]
    local wo = vim.wo[0]

    -- Automatically insert line breaks at 80 characters
    bo.textwidth = 80

    -- Format options for auto-wrapping
    -- 't' = auto-wrap text using textwidth
    -- 'c' = auto-wrap comments
    -- 'r' = auto insert comment leader after <Enter> in Insert mode
    -- 'o' = auto insert comment leader after 'o' or 'O' in Normal mode
    -- 'q' = allow formatting with 'gq'
    -- 'n' = recognize numbered lists
    -- 'l' = long lines are not broken in insert mode
    vim.opt_local.formatoptions:append("t")
    vim.opt_local.formatoptions:append("c")

    -- Visual wrapping at word boundaries
    wo.wrap = true
    wo.linebreak = true
  end,
})
