-- Sync clipboard between OS and Neovim. Schedule to improve startup time
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Sets how neovim will display certain whitespace characters in the editor, using vim.opt to utilize tables
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.g.have_nerd_font = true
vim.o.breakindent = true
vim.o.confirm = false -- do not confirm quit
vim.o.cursorline = true -- Show which line your cursor is on
vim.o.inccommand = "split" -- Preview substitutions live, as you type!
vim.o.mouse = "a" -- enable mouse mode
vim.o.number = true -- absolute number of current line
vim.o.relativenumber = true -- show relative line numbers
vim.o.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
vim.o.showmode = false -- Don't show the mode, since it's already in the status line
vim.o.signcolumn = "yes" -- Keep signcolumn on by default
vim.o.splitbelow = true
vim.o.splitright = true -- Configure how new splits should be opened
vim.o.timeoutlen = 300 -- Decrease mapped sequence wait time
vim.o.undofile = true -- Enable undo/redo changes even after closing and reopening a file
vim.o.updatetime = 250 -- Decrease update time
