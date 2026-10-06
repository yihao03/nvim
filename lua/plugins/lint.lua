return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        golangcilint = function()
          local linter = require("lint.linters.golangcilint")

          -- nvim-lint only checks GOMOD. At a go.work root GOMOD is
          -- /dev/null, so its default target incorrectly becomes one file.
          -- Lint the containing package so sibling files are type-checked too.
          linter.args[#linter.args] = function()
            return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
          end

          return linter
        end,
      },
    },
  },
}
