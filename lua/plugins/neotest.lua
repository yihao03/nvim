return {
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/nvim-nio" },
    opts = {
      -- Can be a list of adapters like what neotest expects,
      -- or a list of adapter names,
      -- or a table of adapter names, mapped to adapter configs.
      -- The adapter will then be automatically loaded with the config.
      adapters = {
        ["neotest-python"] = {
          runner = "pytest",
          is_test_file = function(file_path)
            return file_path:match("ps%d+%.py$")
          end,
          python = "/home/yihao/anaconda3/envs/cs2109s-ay2526s1/bin/python",
        },
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
      quickfix = {
        open = function()
          if LazyVim.has("trouble.nvim") then
            require("trouble").open({ mode = "quickfix", focus = false })
          else
            vim.cmd("copen")
          end
        end,
      },
    },
  -- stylua: ignore
  keys = {
    {"<leader>t", "", desc = "+test"},
    { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
    { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files (Neotest)" },
    { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest (Neotest)" },
    { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last (Neotest)" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary (Neotest)" },
    { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel (Neotest)" },
    { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop (Neotest)" },
    { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch (Neotest)" },
  },
  },
}
