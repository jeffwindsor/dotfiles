local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>hh',  ':Telescope help_tags<CR>', opts)
map('n', '<leader>hm',  ':Telescope man_pages<CR>', opts)
--buffers
map('n', '<leader>bb',  ':Telescope buffers<CR>', opts)
--commands
map('n', '<leader>cc',  ':Telescope commands<CR>', opts)
map('n', '<leader>ch',  ':Telescope command_history<CR>', opts)
map('n', '<leader>cy',  ':Telescope registers<CR>', opts)
--colors
map('n', '<leader>cs',  ':Telescope colorscheme<CR>', opts)
--files
map('n', '<leader>fc',  ':Telescope find_files cwd=$XDG_CONFIG_HOME<CR>', opts)
map('n', '<leader>fd',  ':Telescope find_files cwd=$DOTFILES<CR>', opts)
map('n', '<leader>ff',  ':Telescope find_files<CR>', opts)
map('n', '<leader>fh',  ':Telescope find_files cwd=$HOME<CR>', opts)
map('n', '<leader>fi',  ':Telescope find_files cwd=$INSTALLS<CR>', opts)
map('n', '<leader>fs',  ':Telescope find_files cwd=$SRC<CR>', opts)
--filetypes
map('n', '<leader>ft',  ':Telescope filetypes<CR>', opts)
--git
map('n', '<leader>gb',  ':Telescope git_branches<CR>', opts)
map('n', '<leader>gc',  ':Telescope git_commits<CR>', opts)
map('n', '<leader>gf',  ':Telescope git_files<CR>', opts)
map('n', '<leader>gs',  ':Telescope git_status<CR>', opts)
--search
map('n', '<leader>s',   ':Telescope live_grep<CR>', opts)
--map('n', '<leader>ss',  ':Telescope grep_string<CR>', opts)
