-- Bootstrap mini.nvim and mini.deps
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'

if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up mini.deps
require('mini.deps').setup({ path = { package = path_package } })
local add = MiniDeps.add

-- file explorer
add('stevearc/oil.nvim')
require('oil').setup()

-- git decorations
add('lewis6991/gitsigns.nvim')
require('gitsigns').setup()

-- auto-save
add({
  source = 'okuuva/auto-save.nvim',
  checkout = 'v1.0.0'
})
require('auto-save').setup({
  events = {"InsertLeave", "TextChanged"}
})

-- swiss army knife plugin library
add('echasnovski/mini.nvim')

-- mini.nvim 
require('mini.ai').setup()
require('mini.align').setup()
require('mini.basics').setup()
require('mini.bracketed').setup()
require('mini.clue').setup({
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key (goto mode - Helix style)
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- `m` key (match mode - Helix style)
    { mode = 'n', keys = 'm' },
    { mode = 'x', keys = 'm' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key (view mode)
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },

    -- Buffer navigation (Helix style with [ and ])
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },
    { mode = 'n', keys = '\\' },
  },

  clues = {
    -- Leader key groups (Helix space mode)
    { mode = 'n', keys = '<Leader>n', desc = 'New file' },
    { mode = 'n', keys = '<Leader>q', desc = 'Write-quit all' },
    { mode = 'n', keys = '<Leader>Q', desc = 'Quit (force)' },
    { mode = 'n', keys = '<Leader><Down>', desc = 'Sort lines' },
    { mode = 'n', keys = '<Leader><Up>', desc = 'Sort reverse' },

    -- Case conversion submenu (Helix space-minus mode)
    { mode = 'n', keys = '<Leader>-', desc = '+Case conversion' },
    { mode = 'n', keys = '<Leader>-s', desc = 'snake_case' },
    { mode = 'n', keys = '<Leader>-c', desc = 'camelCase' },
    { mode = 'n', keys = '<Leader>-p', desc = 'PascalCase' },
    { mode = 'n', keys = '<Leader>-k', desc = 'kebab-case' },
    { mode = 'n', keys = '<Leader>-S', desc = 'SCREAMING_SNAKE' },
    { mode = 'n', keys = '<Leader>-u', desc = 'UPPERCASE' },
    { mode = 'n', keys = '<Leader>-l', desc = 'lowercase' },
    { mode = 'n', keys = '<Leader>-t', desc = 'Title Case' },

    -- Theme submenu (Helix space-t mode)
    { mode = 'n', keys = '<Leader>t', desc = '+Themes' },
    { mode = 'n', keys = '<Leader>ta', desc = 'Autumn Night' },
    { mode = 'n', keys = '<Leader>tc', desc = 'Catppuccin Mocha' },
    { mode = 'n', keys = '<Leader>te', desc = 'Ayu Evolve' },
    { mode = 'n', keys = '<Leader>tg', desc = 'Gruvbox' },
    { mode = 'n', keys = '<Leader>tk', desc = 'Kanagawa' },
    { mode = 'n', keys = '<Leader>tm', desc = 'Murmur' },
    { mode = 'n', keys = '<Leader>ts', desc = 'Solarized Osaka' },
    { mode = 'n', keys = '<Leader>tt', desc = 'Tokyo Night' },

    -- Config files submenu (Helix space-space mode)
    { mode = 'n', keys = '<Leader><Leader>', desc = '+Config files' },
    { mode = 'n', keys = '<Leader><Leader>c', desc = 'Config open' },
    { mode = 'n', keys = '<Leader><Leader>l', desc = 'Languages config' },
    { mode = 'n', keys = '<Leader><Leader>r', desc = 'Config reload' },
    { mode = 'n', keys = '<Leader><Leader>.', desc = 'Dotfiles' },
    { mode = 'n', keys = '<Leader><Leader>a', desc = 'Shell config' },
    { mode = 'n', keys = '<Leader><Leader>e', desc = 'Exocortex' },

    -- Goto mode clues (Helix g mode)
    { mode = 'n', keys = 'gg', desc = 'Go to first line' },
    { mode = 'n', keys = 'ge', desc = 'Go to last line' },
    { mode = 'n', keys = 'gh', desc = 'Go to line start' },
    { mode = 'n', keys = 'gl', desc = 'Go to line end' },
    { mode = 'n', keys = 'gs', desc = 'Go to first non-blank' },
    { mode = 'n', keys = 'gd', desc = 'Go to definition' },
    { mode = 'n', keys = 'gr', desc = 'Go to references' },
    { mode = 'n', keys = 'gi', desc = 'Go to implementation' },
    { mode = 'n', keys = 'gt', desc = 'Go to type definition' },

    -- Match mode clues (Helix m mode)
    { mode = 'n', keys = 'mm', desc = 'Match bracket' },
    { mode = 'n', keys = 'ms', desc = 'Surround add' },
    { mode = 'n', keys = 'mr', desc = 'Surround replace' },
    { mode = 'n', keys = 'md', desc = 'Surround delete' },
    { mode = 'n', keys = 'ma', desc = 'Select around' },
    { mode = 'n', keys = 'mi', desc = 'Select inside' },

    -- Window mode clues (standard vim)
    { mode = 'n', keys = '<C-w>s', desc = 'Split horizontal' },
    { mode = 'n', keys = '<C-w>v', desc = 'Split vertical' },
    { mode = 'n', keys = '<C-w>w', desc = 'Switch window' },
    { mode = 'n', keys = '<C-w>h', desc = 'Go to left window' },
    { mode = 'n', keys = '<C-w>j', desc = 'Go to below window' },
    { mode = 'n', keys = '<C-w>k', desc = 'Go to above window' },
    { mode = 'n', keys = '<C-w>l', desc = 'Go to right window' },
    { mode = 'n', keys = '<C-w>c', desc = 'Close window' },
    { mode = 'n', keys = '<C-w>o', desc = 'Close other windows' },

    -- Buffer navigation (Helix style)
    { mode = 'n', keys = '[[', desc = 'Previous buffer' },
    { mode = 'n', keys = ']]', desc = 'Next buffer' },
    { mode = 'n', keys = '\\\\', desc = 'Close buffer' },

    -- Enhance this by adding built-in completion
    require('mini.clue').gen_clues.builtin_completion(),
    -- Enhance this by adding default g, z, marks, and registers
    require('mini.clue').gen_clues.g(),
    require('mini.clue').gen_clues.z(),
    require('mini.clue').gen_clues.marks(),
    require('mini.clue').gen_clues.registers(),
    require('mini.clue').gen_clues.windows({
      submode_move = true,
      submode_navigate = true,
      submode_resize = true,
    }),
  },

  window = {
    delay = 500,
    config = {
      width = 'auto',
    },
  },
})
require('mini.comment').setup()
require('mini.completion').setup()
require('mini.hipatterns').setup()
-- require('mini.hues').setup()
require('mini.indentscope').setup()
require('mini.jump').setup()
require('mini.jump2d').setup()
require('mini.keymap').setup()
require('mini.notify').setup()
require('mini.pick').setup()
require('mini.splitjoin').setup()
require('mini.statusline').setup()
require('mini.surround').setup()
require('mini.tabline').setup()
require('mini.trailspace').setup()

-- Auto-remove trailing spaces on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    MiniTrailspace.trim()
  end,
})

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set colorscheme
vim.cmd [[color minispring]]
