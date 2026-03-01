return {
  input = { "%w+%b()", "^.-%((.-).-)()$" },
  output = function()
    local fun_name = vim.fn.input("Function name: ")
    if fun_name == "" then
      return nil
    end
    return { left = fun_name .. "(", right = ")" }
  end,
}
