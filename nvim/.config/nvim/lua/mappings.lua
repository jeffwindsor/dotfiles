local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

--=============================================================================
-- editor 
--=============================================================================
vim.g.mapleader = " "                                                 -- set map leader to space 
map('i', 'jk', '<ESC>', opts)                                         -- use jk also as <escape> 
map('n', ';', ':', opts)                                              -- get to command mode without the shift key
map('v', ';', ':', opts)                                              -- get to command mode without the shift key
map('n', 'Y', 'y$', opts)                                             -- make yank act like other capitol letters
