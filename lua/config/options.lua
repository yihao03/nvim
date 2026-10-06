vim.opt.clipboard = "unnamedplus"

-- Prefer the nearest Go module over the enclosing Git repository/workspace.
vim.g.root_spec = vim.list_extend({ { "go.mod" } }, vim.g.root_spec or {})
