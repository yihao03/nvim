-- Vim options
local opt = vim.opt

-- General
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.mouse = "a" -- Enable mouse support
opt.undofile = true -- Enable persistent undo
opt.undolevels = 10000
opt.updatetime = 200 -- Faster completion
opt.timeoutlen = 300

-- UI
opt.number = true -- Show line numbers
opt.relativenumber = true -- Relative line numbers
opt.signcolumn = "yes" -- Always show sign column
opt.cursorline = true -- Highlight current line
opt.termguicolors = true -- True color support
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in popup
opt.showmode = false -- Don't show mode in cmdline
opt.list = true -- Show invisible characters
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "q",
  eob = " ",
}

-- Editing
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Size of indent
opt.tabstop = 2 -- Number of spaces tabs count for
opt.softtabstop = 2
opt.smartindent = true -- Insert indents automatically
opt.shiftround = true -- Round indent
opt.wrap = false -- Disable line wrap

-- Search
opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Don't ignore case with capitals
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- Splits
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.splitkeep = "screen"

-- Performance
opt.lazyredraw = false
opt.updatetime = 200

-- Folding
opt.foldlevel = 99
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ""

-- Other
opt.scrolloff = 4 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context
opt.confirm = true -- Confirm to save changes before exiting
opt.conceallevel = 2 -- Hide * markup for bold and italic
opt.formatoptions = "jcroqlnt" -- tcqj
opt.inccommand = "nosplit" -- Preview incremental substitute
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.smoothscroll = true
opt.spelllang = { "en" }
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
