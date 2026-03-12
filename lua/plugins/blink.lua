return {
  {
    "saghen/blink.cmp",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "super-tab",
        ["<Tab>"] = {
          require("blink.cmp.keymap.presets").get("super-tab")["<Tab>"][1],
          "snippet_forward",
          "fallback",
        },
        ["<C-y>"] = {
          function(cmp)
            if LazyVim.cmp.actions.ai_accept then
              return LazyVim.cmp.actions.ai_accept()
            end
          end,
          "fallback",
        },
        ["<S-Tab>"] = { "select_next", "fallback" },
      },
    },
  },
}
