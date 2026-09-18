return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.keymap = {
        ["<S-CR>"] = { "select_and_accept", "fallback" },
        ["<C-y>"] = { LazyVim.cmp.map({ "ai_accept" }) },
        ["<Tab>"] = { "snippet_forward", "fallback" },
      }
    end,
  },
}
