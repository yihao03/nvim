local MATRIX = {
  pane = 2,
  section = "terminal",
  cmd = "cmatrix -s -C cyan",
  height = 17,
  padding = 1,
  ttl = 0,
}

--- Read a 1-byte flag file. Returns true if "1", false otherwise.
--- Returns `default` when the file doesn't exist.
local function read_flag(path, default)
  local f = io.open(path, "r")
  if not f then
    return default
  end
  local val = f:read(1) == "1"
  f:close()
  return val
end

--- Spawn a single background job that writes "1" or "0" into each
--- cache file based on whether `gh` reports open items. Guarded by
--- a vim.g flag so it runs at most once per Neovim session per repo.
local function refresh_gh_cache(issues_path, prs_path, guard_key)
  if vim.g[guard_key] then
    return
  end
  vim.g[guard_key] = true

  local ei = vim.fn.shellescape(issues_path)
  local ep = vim.fn.shellescape(prs_path)
  vim.fn.mkdir(vim.fn.fnamemodify(issues_path, ":h"), "p")
  vim.fn.jobstart({ "sh", "-c", table.concat({
    "i=$(gh issue list -L 1 --json number 2>/dev/null) || exit 0",
    '[ "$i" = "[]" ] && echo 0 > ' .. ei .. " || echo 1 > " .. ei,
    "p=$(gh pr list -L 1 --json number 2>/dev/null) || exit 0",
    '[ "$p" = "[]" ] && echo 0 > ' .. ep .. " || echo 1 > " .. ep,
  }, "; ") }, { detach = true })
end

--- Build the pane-2 sections: cmatrix or GitHub issues/PRs.
local function gh_sections()
  local git_root = Snacks.git.get_root()
  if not git_root then
    return { MATRIX }
  end

  local cache_dir = vim.fn.stdpath("cache") .. "/dashboard_gh"
  local id = vim.fn.sha256(git_root)
  local issues_path = cache_dir .. "/" .. id .. "_issues"
  local prs_path = cache_dir .. "/" .. id .. "_prs"

  refresh_gh_cache(issues_path, prs_path, "dashboard_gh_" .. id)

  -- Default true on first visit so we optimistically show sections.
  if not read_flag(issues_path, true) and not read_flag(prs_path, true) then
    return { MATRIX }
  end

  local cmds = {
    {
      title = "Open Issues",
      cmd = "gh issue list -L 3",
      key = "i",
      action = function()
        vim.fn.jobstart("gh issue list --web", { detach = true })
      end,
      icon = " ",
      height = 7,
    },
    {
      icon = " ",
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
      padding = 1,
      ttl = 5 * 60,
      indent = 3,
    }, cmd)
  end, cmds)
end

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
        gh_sections,
      },
    },
    picker = {
      actions = {
        ["o"] = function(_, item)
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
        end,
      },
    },
  },
}
