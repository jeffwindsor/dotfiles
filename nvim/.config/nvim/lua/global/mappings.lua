local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " " 

-- use jk as escape 
map('i', 'jk', '<ESC>', opts)

-- do not need shift to enter command mode
map('n', ';', ':', opts)
map('v', ';', ':', opts)

-- yank act like other capitol letters
map('n', 'Y', 'y$', opts)

--leader maps
map('n', '<leader>q',   '<Cmd>quit<CR>', opts)
map('n', '<leader>rr',  '<Cmd>source $MYVIMRC<CR>', opts)
--commands
--colors
map('n', '<leader>cl',  '<Cmd>set background=light<CR>', opts)
map('n', '<leader>cd',  '<Cmd>set background=dark<CR>', opts)
--files
map('n', '<leader>e',   '<Cmd>Neotree toggle<CR>', opts)
--filetypes
--git
--packages
map('n', '<leader>pc',  '<Cmd>source $MYVIMRC<CR> :PackerClean<CR>', opts)
map('n', '<leader>pi',  '<Cmd>source $MYVIMRC<CR> :PackerInstall<CR>', opts)
map('n', '<leader>ps',  '<Cmd>source $MYVIMRC<CR> :PackerSync<CR>', opts)
map('n', '<leader>pu',  '<Cmd>source $MYVIMRC<CR> :PackerUpdate<CR>', opts)
--search
--tabs
map('n', '<leader>tn',  '<Cmd>tabnew<cr>', opts)
map('n', '<leader>tl',  '<Cmd>tabnext<cr>', opts)
map('n', '<leader>tc',  '<Cmd>tabclose<cr>', opts)
--windows
map('n', '<leader>wc',  '<Cmd>close<CR> ', opts)
map('n', '<leader>wh',  '<C-W><left> ', opts)
map('n', '<leader>wj',  '<C-W><down> ', opts)
map('n', '<leader>wk',  '<C-W><up> ', opts)
map('n', '<leader>wl',  '<C-W><right> ', opts)
map('n', '<leader>ws',  '<Cmd>split<CR>', opts)
map('n', '<leader>wv',  '<Cmd>vsplit<CR>', opts)
map('n', '<leader>wxh', '<Cmd>vertical resize -5<CR>', opts)
map('n', '<leader>wxj', '<Cmd>resize -5<CR>', opts)
map('n', '<leader>wxk', '<Cmd>resize +5<CR>', opts)
map('n', '<leader>wxl', '<Cmd>vertical resize +5<CR>', opts)
