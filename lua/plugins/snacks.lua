return {
  "snacks.nvim",
  opts = {
    dashboard = {
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
        -- { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = { 2, 2 } },
        { section = "recent_files", indent = 2, padding = { 2, 2 } },
        -- { section = "keys", gap = 1, padding = 1 },
        -- { section = "startup" },
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
