return {
  "snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = [[
 ░▒▓█▓▒░░▒▓█▓▒░▒▓██████████████▓▒░░▒▓██████████████▓▒░       
 ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      
 ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      
 ░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      
 ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      
 ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓██▓▒
 ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓██▓▒
                                                             
                                                             
]],
      },
      sections = {
        { section = "header" },
        { pane = 1, section = "recent_files" },
        function()
          local in_git = Snacks.git.get_root() ~= nil

          if not in_git then
            return {
              {
                pane = 2,
                section = "terminal",
                cmd = "cmatrix -s -C cyan",
                height = 17,
                padding = 1,
                ttl = 0,
              },
            }
          end

          local cmds = {
            {
              title = "Open Issues",
              cmd = "gh issue list -L 3",
              key = "i",
              action = function()
                vim.fn.jobstart("gh issue list --web", { detach = true })
              end,
              icon = " ",
              height = 7,
            },
            {
              icon = " ",
              title = "Open PRs",
              cmd = "gh pr list -L 3",
              key = "P",
              action = function()
                vim.fn.jobstart("gh pr list --web", { detach = true })
              end,
              height = 7,
            },
          }
          return vim.tbl_map(function(cmd)
            return vim.tbl_extend("force", {
              pane = 2,
              section = "terminal",
              enabled = in_git,
              padding = 1,
              ttl = 5 * 60,
              indent = 3,
            }, cmd)
          end, cmds)
        end,
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
}
