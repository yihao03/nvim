return {
  -- Configure Mason to install pyrefly
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyrefly",
      },
    },
  },

  -- Configure nvim-lspconfig for pyrefly
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Disable default Python LSP servers
        pyright = {
          enabled = false,
        },
        basedpyright = {
          enabled = false,
        },
        -- Enable and configure pyrefly
        pyrefly = {
          enabled = true,
          cmd = { "pyrefly", "lsp" },
          filetypes = { "python" },
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern(
              "pyrefly.toml",
              "pyproject.toml",
              "setup.py",
              "setup.cfg",
              "requirements.txt",
              "Pipfile",
              ".git"
            )(fname)
          end,
          single_file_support = true,
          settings = {
            python = {
              analysis = {
                -- Add any pyrefly-specific settings here if needed
              },
            },
          },
        },
      },
    },
  },
}
