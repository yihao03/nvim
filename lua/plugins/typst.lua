---@param path string buffer path to find vendored fonts for
---@return string[] font dirs containing .ttf files under the file's root
local function vendored_font_dirs(path)
  local root = vim.fs.dirname(vim.fn.fnamemodify(path, ":p"))
  local ttfs = vim.fn.globpath(root, "**/*.ttf", false, true)
  local seen, dirs = {}, {}
  for _, f in ipairs(ttfs) do
    local dir = vim.fs.dirname(f)
    if not seen[dir] then
      seen[dir] = true
      dirs[#dirs + 1] = dir
    end
  end
  return dirs
end

-- Remember the chosen output per input file
local output_cache_dir = vim.fn.stdpath("cache") .. "/typst-compile"

---@param input string absolute input path
---@return string cache file holding the remembered output for this input
local function output_cache_path(input)
  return output_cache_dir .. "/" .. vim.fn.sha256(input) .. "_output"
end

---@param input string absolute input path
---@return string|nil remembered absolute output path, if any
local function remembered_output(input)
  local f = io.open(output_cache_path(input), "r")
  if not f then
    return nil
  end
  local val = f:read("*l")
  f:close()
  if val == nil or val == "" then
    return nil
  end
  return val
end

---@param input string absolute input path
---@param output string absolute output path to remember
local function remember_output(input, output)
  vim.fn.mkdir(output_cache_dir, "p")
  local f = io.open(output_cache_path(input), "w")
  if not f then
    return
  end
  f:write(output)
  f:close()
end

---@param choice string raw output from the prompt
---@param input_dir string directory to resolve relative choices against
---@return string absolute output path (or "-" for stdout)
local function resolve_output(choice, input_dir)
  if choice == "-" or choice:match("^/") or choice:match("^%a:[\\/]") then
    return choice
  end
  return input_dir .. "/" .. choice
end

---Prompt for an output name (defaulting to the remembered one, else the
---input basename with .pdf) and compile the current .typ buffer with the
---Mason-installed tinymist.
local function compile_pdf()
  local buf_name = vim.api.nvim_buf_get_name(0)
  if buf_name == "" or vim.fn.fnamemodify(buf_name, ":e") ~= "typ" then
    vim.notify("Not a Typst file", vim.log.levels.WARN)
    return
  end
  if vim.bo.modified then
    vim.cmd("write")
  end
  local tinymist = vim.fn.exepath("tinymist")
  if tinymist == "" then
    tinymist = vim.fn.stdpath("data") .. "/mason/bin/tinymist"
  end
  if vim.fn.executable(tinymist) ~= 1 then
    vim.notify("tinymist not found (install via :Mason)", vim.log.levels.ERROR)
    return
  end
  local input = vim.fn.fnamemodify(buf_name, ":p")
  local input_dir = vim.fs.dirname(input)
  local default = remembered_output(input) or (vim.fn.fnamemodify(buf_name, ":p:r") .. ".pdf")
  vim.ui.input({ prompt = "Output file: ", default = default, completion = "file" }, function(choice)
    if choice == nil or choice == "" then
      return
    end
    local output = resolve_output(choice, input_dir)
    remember_output(input, output)
    local cmd = { tinymist, "compile", input, output }
    local font_dirs = vendored_font_dirs(input)
    if #font_dirs > 0 then
      vim.list_extend(cmd, { "--font-path", table.concat(font_dirs, ":") })
    end
    vim.notify("Compiling " .. vim.fn.fnamemodify(input, ":t") .. " ...", vim.log.levels.INFO)
    -- tinymist derives the project root from CWD and refuses inputs
    -- outside of it ("Escapes"), so run from the input's directory.
    vim.system(cmd, { text = true, cwd = input_dir }, function(res)
      vim.schedule(function()
        if res.code == 0 then
          vim.notify("Compiled -> " .. vim.fn.fnamemodify(output, ":t"), vim.log.levels.INFO)
        else
          vim.notify(
            "tinymist compile failed:\n" .. vim.trim(res.stderr ~= "" and res.stderr or res.stdout),
            vim.log.levels.ERROR
          )
        end
      end)
    end)
  end)
end

return {
  {
    "chomosuke/typst-preview.nvim",
    keys = {
      { "<leader>co", compile_pdf, ft = "typst", desc = "Compile (tinymist)" },
    },
    opts = {
      -- Recursively search the repo for vendored .ttf fonts and hand their
      -- directories to `tinymist preview`, so the preview uses the same
      -- typefaces as a `compile --font-path ...` build. Finds none -> passes
      -- nothing and the preview falls back to system fonts as before.
      extra_args = function(path)
        local dirs = vendored_font_dirs(path)
        if #dirs == 0 then
          return nil
        end
        return { "--font-path", table.concat(dirs, ":") }
      end,
    },
  },
}
