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
          if item.path then
            -- Convert Linux path to Windows path
            local winpath = vim.fn.systemlist({ "wslpath", "-w", item.path })[1]
            -- Use PowerShell to open the file with its default app
            vim.fn.jobstart({
              "powershell.exe",
              "-NoProfile",
              "-Command",
              'ii "' .. winpath .. '"',
            }, { detach = true })
          end
        end,
      },
    },
  },
}
