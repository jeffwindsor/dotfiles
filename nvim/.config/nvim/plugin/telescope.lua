local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>hh',  '<Cmd>Telescope help_tags<CR>', opts)
map('n', '<leader>hm',  '<Cmd>Telescope man_pages<CR>', opts)
--buffers
map('n', '<leader>bb',  '<Cmd>Telescope buffers<CR>', opts)
--commands
map('n', '<leader>cc',  '<Cmd>Telescope commands<CR>', opts)
map('n', '<leader>ch',  '<Cmd>Telescope command_history<CR>', opts)
map('n', '<leader>\'',  '<Cmd>Telescope registers<CR>', opts)
--colors
map('n', '<leader>cs',  '<Cmd>Telescope colorscheme<CR>', opts)
--files
map('n', '<leader>fb',  '<Cmd>Telescope file_browser<CR>', opts)
map('n', '<leader>fc',  '<Cmd>Telescope find_files cwd=$XDG_CONFIG_HOME<CR>', opts)
map('n', '<leader>fd',  '<Cmd>Telescope find_files cwd=$DOTFILES<CR>', opts)
map('n', '<leader>ff',  '<Cmd>Telescope find_files<CR>', opts)
map('n', '<leader>fh',  '<Cmd>Telescope find_files cwd=$HOME<CR>', opts)
map('n', '<leader>fi',  '<Cmd>Telescope find_files cwd=$INSTALLS<CR>', opts)
map('n', '<leader>fs',  '<Cmd>Telescope find_files cwd=$SRC<CR>', opts)
--filetypes
map('n', '<leader>ft',  '<Cmd>Telescope filetypes<CR>', opts)
--git
map('n', '<leader>gb',  '<Cmd>Telescope git_branches<CR>', opts)
map('n', '<leader>gc',  '<Cmd>Telescope git_commits<CR>', opts)
map('n', '<leader>gf',  '<Cmd>Telescope git_files<CR>', opts)
map('n', '<leader>gs',  '<Cmd>Telescope git_status<CR>', opts)
--search
map('n', '<leader>ss',   '<Cmd>Telescope live_grep<CR>', opts)

local telescope = require('telescope')

telescope.setup{
    defaults = {
      layout_strategy = 'vertical',
      layout_config = { prompt_position = 'top' },
      sorting_strategy = 'ascending',
    },
    extensions = {
      file_browser = {
        hidden = true,
        --layout_strategy = 'horizontal',
      }
    }
  }

telescope.load_extension('file_browser')
--telescope.load_extension('project')
