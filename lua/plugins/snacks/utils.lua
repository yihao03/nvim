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
local function refresh_gh_cache(issues_path, prs_path, guard_key, fetch_object)
  if vim.g[guard_key] then
    return
  end
  vim.g[guard_key] = true

  local ei = vim.fn.shellescape(issues_path)
  local ep = vim.fn.shellescape(prs_path)
  vim.fn.mkdir(vim.fn.fnamemodify(issues_path, ":h"), "p")
  vim.fn.jobstart({
    "sh",
    "-c",
    table.concat({
      "i=$(" .. fetch_object.issue.check .. " || exit 0)",
      '[ "$i" = "[]" ] && echo 0 > ' .. ei .. " || echo 1 > " .. ei,
      "p=$(" .. fetch_object.pr.check .. " || exit 0)",
      '[ "$p" = "[]" ] && echo 0 > ' .. ep .. " || echo 1 > " .. ep,
    }, "; "),
  }, { detach = true })
end

local M = {
  read_flag = read_flag,
  refresh_gh_cache = refresh_gh_cache,
}

return M
