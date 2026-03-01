local M = {}

--- Schedule cursor placement at a specific column on the line above the current cursor position,
--- then enter insert mode. Intended for use in mini.surround custom surroundings where the `left`
--- string contains a newline, so the condition to fill in is one line above where the cursor lands.
---@param cursor_col_offset number 0-indexed column to place the cursor at
function M.schedule_cursor_to_condition(cursor_col_offset)
  vim.schedule(function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_win_set_cursor(0, { pos[1] - 1, cursor_col_offset })
    vim.cmd("startinsert")
  end)
end

return M
