return {
  input = { "\\%w+%b{}", "^.-{().*()}$" },
  output = function()
    local cmd_name = vim.fn.input("LaTeX command: ")
    if cmd_name == "" then
      return nil
    end
    return { left = "\\" .. cmd_name .. "{", right = "}" }
  end,
}
