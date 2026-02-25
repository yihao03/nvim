local function open_cmd(_, item)
  if not item.path then
    return
  end

  if vim.fn.has("wsl") == 1 then
    local winpath = vim.fn.systemlist({ "wslpath", "-w", item.path })[1]
    if not winpath or winpath == "" then
      vim.notify("Failed to convert path: " .. item.path, vim.log.levels.ERROR)
      return
    end
    vim.fn.jobstart({
      "powershell.exe",
      "-NoProfile",
      "-Command",
      'ii "' .. winpath .. '"',
    }, { detach = true })
  else
    local open_cmd = vim.fn.has("mac") == 1 and "open" or "xdg-open"
    vim.fn.jobstart({ open_cmd, item.path }, { detach = true })
  end
end

return open_cmd
