return {
  "nvim-mini/mini.surround",
  opts = {
    custom_surroundings = {
      f = require("plugins.surround.function"),
      t = require("plugins.surround.tag"),
      l = require("plugins.surround.latex"),
      a = require("plugins.surround.align"),
      b = require("plugins.surround.bold"),
      i = require("plugins.surround.if_statement"),
    },
  },
}
