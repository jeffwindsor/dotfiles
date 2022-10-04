local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>pc',  '<Cmd>source $MYVIMRC<CR> :PackerClean<CR>', opts)
map('n', '<leader>pi',  '<Cmd>source $MYVIMRC<CR> :PackerInstall<CR>', opts)
map('n', '<leader>ps',  '<Cmd>source $MYVIMRC<CR> :PackerSync<CR>', opts)
map('n', '<leader>pu',  '<Cmd>source $MYVIMRC<CR> :PackerUpdate<CR>', opts)
