local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>pc',  '<Cmd>luafile %<CR> <Cmd>PackerClean<CR>', opts)
map('n', '<leader>pi',  '<Cmd>luafile %<CR> <Cmd>PackerInstall<CR>', opts)
map('n', '<leader>ps',  '<Cmd>luafile %<CR> <Cmd>PackerSync<CR>', opts)
map('n', '<leader>pu',  '<Cmd>luafile %<CR> <Cmd>PackerUpdate<CR>', opts)
