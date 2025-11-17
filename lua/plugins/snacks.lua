return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          header = [[
░▒▓█▓▒░░▒▓█▓▒░░▒▓███████▓▒░░▒▓██████▓▒░ ░▒▓██████▓▒░░▒▓███████▓▒░░▒▓████████▓▒░
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░
 ░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░
 ░▒▓█▓▒▒▓█▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░
  ░▒▓█▓▓█▓▒░        ░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░
  ░▒▓█▓▓█▓▒░        ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░
   ░▒▓██▓▒░  ░▒▓███████▓▒░ ░▒▓██████▓▒░ ░▒▓██████▓▒░░▒▓███████▓▒░░▒▓████████▓▒░
]],
        },
        sections = {
          { section = "header" },
          { section = "recent_files", indent = 2, padding = { 2, 2 } },
        },
      },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true },
        },
      },
      picker = {
        actions = {
          ["o"] = function(_, item)
            if not item.path then
              return
            end

            -- Check if running in WSL
            if vim.fn.has("wsl") == 1 then
              -- Convert Linux path to Windows path
              local winpath = vim.fn.systemlist({ "wslpath", "-w", item.path })[1]

              -- Validate path conversion succeeded
              if not winpath or winpath == "" then
                vim.notify("Failed to convert path: " .. item.path, vim.log.levels.ERROR)
                return
              end

              -- Use PowerShell to open the file with its default app
              vim.fn.jobstart({
                "powershell.exe",
                "-NoProfile",
                "-Command",
                'ii "' .. winpath .. '"',
              }, { detach = true })
            else
              -- Native Linux/Mac - use xdg-open/open
              local open_cmd = vim.fn.has("mac") == 1 and "open" or "xdg-open"
              vim.fn.jobstart({ open_cmd, item.path }, { detach = true })
            end
          end,
        },
      },
    },
    keys = {
      { "<leader>.",  function() require("snacks").scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() require("snacks").scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader>n",  function() require("snacks").notifier.show_history() end, desc = "Notification History" },
      { "<leader>bd", function() require("snacks").bufdelete() end, desc = "Delete Buffer" },
      { "<leader>gg", function() require("snacks").lazygit() end, desc = "Lazygit" },
      { "<leader>gb", function() require("snacks").git.blame_line() end, desc = "Git Blame Line" },
      { "<leader>gB", function() require("snacks").gitbrowse() end, desc = "Git Browse" },
      { "<leader>gf", function() require("snacks").lazygit.log_file() end, desc = "Lazygit Current File History" },
      { "<leader>gl", function() require("snacks").lazygit.log() end, desc = "Lazygit Log (cwd)" },
      { "<leader>un", function() require("snacks").notifier.hide() end, desc = "Dismiss All Notifications" },
      { "<c-/>",      function() require("snacks").terminal() end, desc = "Toggle Terminal" },
      { "<c-_>",      function() require("snacks").terminal() end, desc = "which_key_ignore" },
      { "]]",         function() require("snacks").words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[",         function() require("snacks").words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging
          _G.dd = function(...)
            require("snacks").debug.inspect(...)
          end
          _G.bt = function()
            require("snacks").debug.backtrace()
          end
          vim.print = _G.dd
        end,
      })
    end,
  },
}
