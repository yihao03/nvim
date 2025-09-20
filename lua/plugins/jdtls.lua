return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function()
      local cmd = { vim.fn.exepath("jdtls") }
      -- if LazyVim.has("mason.nvim") then
      --   local mason_registry = require("mason-registry")
      --   local lombok_jar = mason_registry.get_package("jdtls"):get_install_path() .. "/lombok.jar"
      --   table.insert(cmd, string.format("--jvm-arg=-javaagent:%s", lombok_jar))
      -- end
      return {
        -- How to find the root dir for a given filename. The default comes from
        -- lspconfig which provides a function specifically for java projects.
        -- root_dir = LazyVim.lsp.get_raw_config("jdtls").default_config.root_dir,

        root_dir = function(fname)
          -- This function defines how the root directory is determined.
          -- It should return the path to the project root.

          -- Example 1: Look for a specific file (e.g., pom.xml for Maven)
          local root = vim.fs.find({ "pom.xml", "build.gradle" }, { upward = true, path = fname })[1]
          if root then
            return vim.fs.dirname(root)
          end

          -- Example 2: If no specific file is found, use the current file's directory as a fallback
          return vim.fs.dirname(fname)
        end,

        -- How to find the project name for a given root dir.
        project_name = function(root_dir)
          return root_dir and vim.fs.basename(root_dir)
        end,

        -- Where are the config and workspace dirs for a project?
        jdtls_config_dir = function(project_name)
          return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
        end,
        jdtls_workspace_dir = function(project_name)
          return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
        end,

        -- How to run jdtls. This can be overridden to a full java command-line
        -- if the Python wrapper script doesn't suffice.
        cmd = cmd,
        full_cmd = function(opts)
          local fname = vim.api.nvim_buf_get_name(0)
          local root_dir = opts.root_dir(fname)
          local project_name = opts.project_name(root_dir)
          local cmd = vim.deepcopy(opts.cmd)
          if project_name then
            vim.list_extend(cmd, {
              "-configuration",
              opts.jdtls_config_dir(project_name),
              "-data",
              opts.jdtls_workspace_dir(project_name),
            })
          end
          return cmd
        end,

        -- These depend on nvim-dap, but can additionally be disabled by setting false here.
        dap = { hotcodereplace = "auto", config_overrides = {} },
        -- Can set this to false to disable main class scan, which is a performance killer for large project
        dap_main = {},
        test = true,
        settings = {
          java = {
            home = "/home/yihao/.sdkman/candidates/java/22.0.2-oracle/",
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-11",
                  path = "/home/yihao/.sdkman/candidates/java/11.0.27.fx-zulu/",
                },
                {
                  name = "JavaSE-17",
                  path = "/home/yihao/.sdkman/candidates/java/17.0.12-oracle/",
                  default = true,
                },
                {
                  name = "JavaSE-22",
                  path = "/home/yihao/.sdkman/candidates/java/22.0.2-oracle/",
                },
              },
            },
            inlayHints = {
              parameterNames = {
                enabled = "all",
              },
            },
            format = {
              enabled = true,
              settings = {
                url = vim.fn.stdpath("config") .. "/styles/java.xml",
              },
            },
            project = {
              sourcePaths = { "src/main/java", "src" },
            },
          },
        },
      }
    end,
  },
}
