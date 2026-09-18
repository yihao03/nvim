return {
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")

      local function build_current_file()
        local src = vim.fn.expand("%:p")
        local ext = vim.fn.expand("%:e")
        local stem = vim.fn.expand("%:t:r"):gsub("[^%w%._-]", "_")
        local out = vim.fn.getcwd() .. "/.debug/" .. stem

        vim.fn.mkdir(vim.fn.fnamemodify(out, ":h"), "p")

        local compiler = (ext == "c") and "gcc" or "g++"
        local cmd = string.format("%s -g -O0 %s -o %s", compiler, vim.fn.shellescape(src), vim.fn.shellescape(out))
        vim.fn.system(cmd)

        if vim.v.shell_error ~= 0 then
          error("Build failed: " .. cmd)
        end

        return out
      end

      for _, lang in ipairs({ "c", "cpp" }) do
        dap.configurations[lang] = {
          {
            type = "codelldb",
            request = "launch",
            name = "Build and launch current file",
            program = build_current_file,
            cwd = "${workspaceFolder}",
          },
        }
      end

      -- keep dap-ui open after session end so program output stays visible
      local ok, dapui = pcall(require, "dapui")
      if ok then
        dap.listeners.before.event_terminated.dapui_config = nil
        dap.listeners.before.event_exited.dapui_config = nil
      end
    end,
  },
}
