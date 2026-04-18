return {
  "folke/trouble.nvim",
  opts = {
    modes = {
      symbols = {
        filter = {
          function(item)
            local client = item.item and item.item.client
            return client ~= "obsidian-ls"
          end,
        },
      },
    },
  },
}