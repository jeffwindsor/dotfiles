local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>gg',  '<Cmd>LazyGit<CR>', opts)
map('n', '<leader>gc',  '<Cmd>LazyGitConfig<CR>', opts)
