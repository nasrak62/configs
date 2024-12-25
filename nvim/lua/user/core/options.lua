vim.cmd("let g:netrw_liststyle = 3")
vim.cmd("let g:netrw_keepdir = 0")
vim.cmd("let g:netrw_winsize = 30")
vim.cmd("let g:netrw_banner = 0")
vim.cmd("let g:netrw_localcopydircmd = 'cp -r'")

local opt = vim.opt
local keymap = vim.keymap

opt.relativenumber = true
opt.number = true
opt.backupcopy = "yes"

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.modifiable = true

opt.wrap = false

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = true

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- Basic clipboard interaction
if vim.fn.has("clipboard") == 1 then
  keymap.set("", "cp", '"+y', { desc = "New copy" })
  keymap.set("", "cv", '"+p', { desc = "New paste" })
end

local function netrw_mapping()
  -- close window
  keymap.set(
    "n",
    "<leader>dd",
    ":Lexplore %:p:h<CR>",
    { desc = "open Netrw in the directory of the current file.", buffer = true, remap = true }
  )

  keymap.set(
    "n",
    "<leader>da",
    ":Lexplore<CR>",
    { desc = "open Netrw in the current working directory.", buffer = true, remap = true }
  )

  keymap.set("n", "a", "%:w<CR>:Ex<CR>:e .<CR>", { desc = "create new file ", buffer = true, remap = true })
end

local user_cmds = vim.api.nvim_create_augroup("user_cmds", { clear = true })

vim.api.nvim_create_autocmd("filetype", {
  pattern = "netrw",
  group = user_cmds,
  desc = "Keybindings for netrw",
  callback = netrw_mapping,
})
