local NYANCAT = require("plugins.snacks.nyancat")
local utils = require("plugins.snacks.utils")
local fetch = require("plugins.snacks.remote")

--- Build the pane-2 sections: cmatrix or GitHub issues/PRs.
local function git_panes()
  local git_root = Snacks.git.get_root()
  if not git_root then
    return { NYANCAT }
  end

  local is_github = vim.fn.system("git remote get-url origin 2>/dev/null"):find("github.com")
  local is_gitlab = vim.fn.system("git remote get-url origin 2>/dev/null"):find("gitlab.com")
  if not is_github and not is_gitlab then
    return { NYANCAT }
  end

  local cache_dir = vim.fn.stdpath("cache") .. "/dashboard_gh"
  local id = vim.fn.sha256(git_root)
  local issues_path = cache_dir .. "/" .. id .. "_issues"
  local prs_path = cache_dir .. "/" .. id .. "_prs"

  local fetch_object = is_github and fetch.gh or fetch.glab

  utils.refresh_gh_cache(issues_path, prs_path, "dashboard_gh_" .. id, fetch_object)

  -- Default true on first visit so we optimistically show sections.
  if not utils.read_flag(issues_path, true) and not utils.read_flag(prs_path, true) then
    return { NYANCAT }
  end

  local cmds = {
    {
      title = "Open Issues",
      cmd = fetch_object.issue.list,
      key = "i",
      action = function()
        vim.fn.jobstart(fetch_object.issue.web, { detach = true })
      end,
      icon = " ",
      height = 9,
    },
    {
      icon = " ",
      title = "Open PRs",
      cmd = fetch_object.pr.list,
      key = "P",
      action = function()
        vim.fn.jobstart(fetch_object.pr.web, { detach = true })
      end,
      height = 9,
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

return git_panes
