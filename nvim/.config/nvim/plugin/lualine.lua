local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators =  { left = '', right = ''}, --{ left = '', right = ''},
    section_separators = { left = '', right = ''}, --{ left = '', right = ''},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'diff', 'diagnostics'},
    lualine_c = {''},
    lualine_x = {},
    lualine_y = {'location'},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {{'tabs', mode = 0}},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {{'filename', file_status = true, path = 3, shorting_target = 100, }}, 
    lualine_z = {},
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}
