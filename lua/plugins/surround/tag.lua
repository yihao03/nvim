return {
  input = { "<(%w-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
  output = function()
    local tag_input = vim.fn.input("Tag (with props): ")
    local tag_name = ""
    if tag_input ~= "" then
      tag_name = tag_input:match("^(%S+)")
    end

    -- Get current line's indentation
    local line_num = vim.fn.line(".")
    local indent = vim.fn.indent(line_num)
    local indent_str = string.rep(" ", indent)
    local inner_indent = string.rep(" ", indent + vim.bo.shiftwidth)

    return {
      left = "<" .. tag_input .. ">\n" .. inner_indent,
      right = "\n" .. indent_str .. "</" .. tag_name .. ">",
    }
  end,
}
