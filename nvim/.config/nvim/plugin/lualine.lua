local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- mappings 
map('n', '<leader>bc',  '<Cmd>bd<CR>', opts)
map('n', '<leader>bd',  '<Cmd>bd<CR>', opts)
map('n', '<leader>bq',  '<Cmd>bd<CR>', opts)
map('n', '<leader>bh',  '<Cmd>bp<CR>', opts)
map('n', '<leader>bl',  '<Cmd>bn<CR>', opts)
map('n', '<leader>1',   '<Cmd>LualineBuffersJump! 1<CR>', opts)
map('n', '<leader>2',   '<Cmd>LualineBuffersJump! 2<CR>', opts)
map('n', '<leader>3',   '<Cmd>LualineBuffersJump! 3<CR>', opts)
map('n', '<leader>4',   '<Cmd>LualineBuffersJump! 4<CR>', opts)
map('n', '<leader>5',   '<Cmd>LualineBuffersJump! 5<CR>', opts)
map('n', '<leader>6',   '<Cmd>LualineBuffersJump! 6<CR>', opts)
map('n', '<leader>7',   '<Cmd>LualineBuffersJump! 7<CR>', opts)
map('n', '<leader>8',   '<Cmd>LualineBuffersJump! 8<CR>', opts)
map('n', '<leader>9',   '<Cmd>LualineBuffersJump! 9<CR>', opts)
map('n', '<leader>0',   '<Cmd>LualineBuffersJump! $<CR>', opts)

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {'buffers'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
