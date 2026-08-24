return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.keymap["<S-Tab>"] = { LazyVim.cmp.map({ "ai_accept" }), "select_and_accept" }
      opts.keymap["<Tab>"] = { "snippet_forward", "fallback" }
    end,
  },
}
