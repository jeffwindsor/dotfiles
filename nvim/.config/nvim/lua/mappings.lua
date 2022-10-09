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
map('n', '<leader>q',   '<Cmd>q<CR>', opts)                           -- quit
map('n', '<leader>x',   '<Cmd>q!<CR>', opts)                          -- quit force
map('n', '<leader>rr',  '<Cmd>luafile %<CR>', opts)                   -- reload config file
map('n', '<leader>cl',  '<Cmd>set background=light<CR>', opts)        -- light theme
map('n', '<leader>cd',  '<Cmd>set background=dark<CR>', opts)         -- dark theme

--=============================================================================
-- buffers (files)
--=============================================================================
map('n', '<leader>bc',  '<Cmd>bdelete<CR>', opts)                     -- close buffer
map('n', '<leader>bj',  '<Cmd>bprevious<CR>', opts)                   -- move focus to previous buffer
map('n', '<leader>bk',  '<Cmd>bnext<CR>', opts)                       -- move focus to next buffer
map('n', '<leader>bn',  '<Cmd>enew<CR>', opts)                        -- new buffer

--========================================================================
-- windows (tiles)
--========================================================================
map('n', '<leader>wc',  '<Cmd>close<CR> ', opts)                      -- close window
map('n', '<leader>wh',  '<C-W><left> ', opts)                         -- move focus to left window 
map('n', '<leader>wj',  '<C-W><down> ', opts)                         -- move focus to below window 
map('n', '<leader>wk',  '<C-W><up> ', opts)                           -- move focus to above window 
map('n', '<leader>wl',  '<C-W><right> ', opts)                        -- move focus to right window 
map('n', '<leader>ws',  '<Cmd>split<CR><Cmd>bnext<CR>', opts)         -- new horizontal window with next buffer
map('n', '<leader>wv',  '<Cmd>vsplit<CR><Cmd>bnext<CR>', opts)        -- new vertical window with next buffer
map('n', '<leader>wxh', '<Cmd>vertical resize -5<CR>', opts)          -- resize current window
map('n', '<leader>wxj', '<Cmd>resize -5<CR>', opts)                   -- resize current window
map('n', '<leader>wxk', '<Cmd>resize +5<CR>', opts)                   -- resize current window
map('n', '<leader>wxl', '<Cmd>vertical resize +5<CR>', opts)          -- resize current window

--========================================================================
-- tabs (workspaces)
--========================================================================
map('n', '<leader>tc',  '<Cmd>tabclose<cr>', opts)                    -- close tab
map('n', '<leader>tj',  '<Cmd>tabprevious<cr>', opts)                 -- move focus to previous tab
map('n', '<leader>tk',  '<Cmd>tabnext<cr>', opts)                     -- move focus to next tab
map('n', '<leader>tn',  '<Cmd>tabnew<cr>', opts)                      -- new tab

