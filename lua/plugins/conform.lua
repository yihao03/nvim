return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      toml = { "taplo" },
    },
    -- Format on save
    format_on_save = function(bufnr)
      -- Check if it's a TOML file
      if vim.bo[bufnr].filetype == "toml" then
        return {
          timeout_ms = 500,
          lsp_fallback = true,
        }
      end
      return nil
    end,
  },
}
