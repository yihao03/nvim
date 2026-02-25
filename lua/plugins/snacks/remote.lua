local gh = {
  issue = {
    list = "gh issue list -L 3",
    check = "gh issue list -L 1 --json number 2>/dev/null",
    web = "gh issue list --web",
  },
  pr = {
    list = "gh pr list -L 3",
    check = "gh pr list -L 1 --json number 2>/dev/null",
    web = "gh pr list --web",
  },
}

local glab = {
  issue = {
    list = "glab issue list -P 3",
    check = "glab issue list -P 1 --json number 2>/dev/null",
    web = "glab issue list --web",
  },
  pr = {
    list = "glab mr list -P 3",
    check = "glab mr list -P 1 --json number 2>/dev/null",
    web = "glab mr list --web",
  },
}

local M = {
  gh = gh,
  glab = glab,
}

return M
