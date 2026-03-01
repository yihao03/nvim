return {
  input = { "\\begin{align%*?}.-\\end{align%*?}", "^\\begin{align%*?}%s*().-()%s*\\end{align%*?}$" },
  output = function()
    return { left = "\\begin{align*}\n", right = "\n\\end{align*}" }
  end,
}
