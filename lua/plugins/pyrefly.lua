-- Override LazyVim's lang.python extra to use pyrefly instead of pyright/basedpyright
-- This configuration disables the default Python LSP servers and enables pyrefly
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
      -- Inlay hints
      inlay_hints = {
        enabled = true,
      },
      -- LSP Server Settings
      servers = {
        -- Explicitly disable pyright (from lang.python extra)
        pyright = {
          enabled = false,
        },
        -- Explicitly disable basedpyright (from lang.python extra)
        basedpyright = {
          enabled = false,
        },
        -- Enable and configure pyrefly as the Python LSP
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
            -- Add pyrefly-specific settings here if needed
          },
        },
      },
      -- Ensure pyrefly LSP is set up properly
      setup = {
        pyrefly = function(_, opts)
          -- This ensures pyrefly is configured before other Python tools
          return false -- let lspconfig handle the setup
        end,
      },
    },
  },
}
