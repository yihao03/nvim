-- Cursor offset from the start of the `left` string to where the condition should be typed.
-- After mini.surround places the cursor at the end of `left`, we schedule a jump back.
local function schedule_cursor_to_condition(cursor_col_offset)
  vim.schedule(function()
    local pos = vim.api.nvim_win_get_cursor(0)
    -- Move cursor to the first line of the surround (one line above current) at the condition offset
    vim.api.nvim_win_set_cursor(0, { pos[1], cursor_col_offset })
    vim.cmd("startinsert")
  end)
end

return {
  input = function()
    return nil -- Deletion not supported for if statements
  end,
  output = function()
    local ft = vim.bo.filetype
    local line_num = vim.fn.line(".")
    local indent = vim.fn.indent(line_num)
    local indent_str = string.rep(" ", indent)
    local inner_indent = string.rep(" ", indent + vim.bo.shiftwidth)

    -- Language-specific if statement formats
    -- cursor_col_offset: column where the condition should be edited (0-indexed)
    if ft == "lua" then
      schedule_cursor_to_condition(indent + 3) -- "if |" (after "if ")
      return {
        left = "if  then\n" .. inner_indent,
        right = "\n" .. indent_str .. "end",
      }
    elseif ft == "typescript" or ft == "javascript" or ft == "typescriptreact" or ft == "javascriptreact" then
      schedule_cursor_to_condition(indent + 4) -- "if (|)" (inside parens)
      return {
        left = "if () {\n" .. inner_indent,
        right = "\n" .. indent_str .. "}",
      }
    elseif ft == "go" then
      schedule_cursor_to_condition(indent + 3) -- "if |" (after "if ")
      return {
        left = "if  {\n" .. inner_indent,
        right = "\n" .. indent_str .. "}",
      }
    elseif ft == "c" or ft == "cpp" then
      schedule_cursor_to_condition(indent + 4) -- "if (|)" (inside parens)
      return {
        left = "if () {\n" .. inner_indent,
        right = "\n" .. indent_str .. "}",
      }
    elseif ft == "rust" then
      schedule_cursor_to_condition(indent + 3) -- "if |" (after "if ")
      return {
        left = "if  {\n" .. inner_indent,
        right = "\n" .. indent_str .. "}",
      }
    else
      vim.notify("Filetype '" .. ft .. "' not supported for if statement surround", vim.log.levels.WARN)
      return nil
    end
  end,
}
