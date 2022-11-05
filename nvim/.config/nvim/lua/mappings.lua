local map     = vim.api.nvim_set_keymap
local noremap = { noremap = true }
local silent  = { noremap = true, silent = true }     -- silent means dont show command in command line

-- map leader to <space> 
vim.g.mapleader = " "           

-------------------------------------------------------------------------------
-- homies
-------------------------------------------------------------------------------

-- quick <jk> produces an <escape> 
map('i', 'jk', '<ESC>', silent)   

-- window movement direct from CONTROL
keymap("n", "<C-h>", "<C-w>h", silent)
keymap("n", "<C-j>", "<C-w>j", silent)
keymap("n", "<C-k>", "<C-w>k", silent)
keymap("n", "<C-l>", "<C-w>l", silent)

-- first character in line
keymap("n", "H", "^", silent)

-- last character in line
keymap("n", "L", "$", silent)

-- return remove highlights
keymap("n", "<CR>", "<Cmd>noh<CR><CR>", silent)

-------------------------------------------------------------------------------
-- simplifiers
-------------------------------------------------------------------------------
-- get to command mode without the shift key (normal and visual mode)
map('n', ';', ':', noremap)
map('v', ';', ':', noremap)

-- make yank act like other capitol letters (normal mode)
map('n', 'Y', 'y$', noremap)


