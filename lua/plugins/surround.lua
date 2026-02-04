return {
  "nvim-mini/mini.surround",
  opts = {
    custom_surroundings = {
      f = {
        input = { "%w+%b()", "^.-%((.-).-)()$" },
        output = function()
          local fun_name = vim.fn.input("Function name: ")
          if fun_name == "" then
            return nil
          end
          return { left = fun_name .. "(", right = ")" }
        end,
      },
      t = {
        input = { "<(%w-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        output = function()
          local tag_name = vim.fn.input("Tag name: ")
          if tag_name == "" then
            return nil
          end

          -- Get current line's indentation
          local line_num = vim.fn.line(".")
          local indent = vim.fn.indent(line_num)
          local indent_str = string.rep(" ", indent)
          local inner_indent = string.rep(" ", indent + vim.bo.shiftwidth)

          return {
            left = "<" .. tag_name .. ">\n" .. inner_indent,
            right = "\n" .. indent_str .. "</" .. tag_name .. ">",
          }
        end,
      },
    },
  },
}
