return {
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      local cache_dir = vim.fn.stdpath("cache") .. "/dap-executables"

      local function choose_executable()
        -- Match LazyVim's default ${workspaceFolder}, without changing it.
        local root = vim.fn.getcwd()
        root = vim.uv.fs_realpath(root) or root
        local cache_file = cache_dir .. "/" .. vim.fn.sha256(root)
        local ok, lines = pcall(vim.fn.readfile, cache_file)
        local path = ok and lines[1] or nil

        while true do
          if not path or vim.fn.executable(path) ~= 1 then
            local accepted, choice = pcall(vim.fn.input, {
              prompt = "Executable to debug: ",
              default = path or root .. "/",
              completion = "file",
            })
            if not accepted or choice == "" then
              return dap.ABORT
            end

            path = vim.fn.expand(choice)
            if path:sub(1, 1) ~= "/" then
              path = root .. "/" .. path
            end
            path = vim.fs.normalize(path)
          end

          if vim.fn.executable(path) ~= 1 then
            vim.notify("Not an executable file: " .. path, vim.log.levels.WARN)
          else
            local accepted, action = pcall(
              vim.fn.confirm,
              "Debug this executable?\n" .. path .. "\nWorking directory: " .. root,
              "&Launch\n&Change\n&Cancel",
              1
            )
            if not accepted or action == 0 or action == 3 then
              return dap.ABORT
            end
            if action == 1 then
              local saved, err = pcall(function()
                vim.fn.mkdir(cache_dir, "p")
                if vim.fn.writefile({ path }, cache_file) ~= 0 then
                  error("could not write executable cache")
                end
              end)
              if not saved then
                vim.notify("Could not remember executable: " .. tostring(err), vim.log.levels.WARN)
              end
              return path
            end
            path = nil
          end
        end
      end

      for _, lang in ipairs({ "c", "cpp" }) do
        for _, config in ipairs(dap.configurations[lang] or {}) do
          if config.type == "codelldb" and config.request == "launch" and config.name == "Launch file" then
            config.program = choose_executable
          end
        end
      end

      -- Keep dap-ui open after session end so program output stays visible.
      local ok, dapui = pcall(require, "dapui")
      if ok then
        dap.listeners.before.event_terminated.dapui_config = nil
        dap.listeners.before.event_exited.dapui_config = nil
      end
    end,
  },
}
