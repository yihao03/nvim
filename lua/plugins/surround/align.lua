return {
  input = { "\\begin{aligned?}.-\\end{align%*?}", "^\\begin{aligned?}%s*().-()%s*\\end{align%*?}$" },
  output = function()
    return { left = "\\begin{aligned}\n", right = "\n\\end{aligned}" }
  end,
}
