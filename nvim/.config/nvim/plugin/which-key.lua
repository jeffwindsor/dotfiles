--
-- Location of all <leader> based key bindings
-- Non-Leader based are in the ./lua/mapping.lua file
--
-- map leader to <space> 
vim.g.mapleader = " "           

-- display "message" in the bottom row / the command output
local function echo(message)
  return '<Cmd>echo "' .. message .. '"<CR>'
end

-- makes "action" a VIM command.  example = <Cmd>action<CR> which is the same as :action<CR>
local function command(action)
  return '<Cmd>' .. action .. '<CR>'
end

---- makes "action" a Telescope command. example = <Cmd>Telescope action<CR>
local function telescope(action)
  return command('Telescope ' .. action)
end

-- re-used commands
local buffer_next = command('bnext')
local load_config = command('luafile %')

-- which key configuration
local wk = require('which-key')
wk.setup()
wk.register({
  ["<leader>"] = { telescope('spell_suggest'), 'spelling'},
  ["."] = { load_config .. echo('Configuration Re-Loaded'), 'load config'}, 
  [","] = { 
    name = 'commands',
    [","] = { telescope('commands'),'commands'},
    a = { telescope('autocommands'), 'auto commands' },
    h = { telescope('command_history'),'command history'},
    p = { telescope('builtin'),'pickers'},
  },
  b = { 
    name = 'buffers',
    b = { telescope('buffers'),'buffers'},
    c = { command('bdelete'),'close'},
    j = { command('bprev'),'previous'},
    k = { buffer_next,'next'},
    n = { command('enew'),'new'},
    s = { telescope('current_buffer_fuzzy_find'), 'search text'},
    t = { telescope('current_buffer_tags'), 'search tags' },
  },
  c = {
    name = 'color schemes',
    c = { telescope('colorscheme'),'color schemes'},
    d = { command('set background=dark'),'dark'},
    l = { command('set background=light'),'light'},
    m = { command(':lua require("material.functions").find_style()'), 'material' },
    o = { command('colorscheme OceanNext'), 'ocean next' },
    k = { command('colorscheme kanagawa'), 'kanagawa' },
    n = { command('colorscheme nord'), 'nord' },
    t = { 
      name = 'tokyo night',
      n = { command('colorscheme tokyonight-night'), 'night' },
      s = { command('colorscheme tokyonight-storm'), 'storm' },
      d = { command('colorscheme tokyonight-day'), 'day' },
      m = { command('colorscheme tokyonight-moon'), 'moon' },
    },
    ["1"] = { command('colorscheme onedark'), 'one dark' },
  },
  f = { 
    name = 'files',
    b = { telescope('file_browser'),'via browser'},
    c = { telescope('find_files cwd=$XDG_CONFIG_HOME'),'in config directory'},
    d = { telescope('find_files cwd=$DOTFILES'),'in dotfiles directory'},
    f = { telescope('find_files'),'in current directory'},
    g = { telescope('find_files cwd=$SRC'),'in git repos'},
    h = { telescope('find_files cwd=$HOME'),'in home directory'},
    i = { telescope('find_files cwd=$INSTALLS'),'in install files directory'},
    p = { telescope('project_files'),'in project'},
    s = { telescope('live_grep'),'grep'},
    t = { telescope('filetypes'),'set file type'},
  },
  g = { 
    name = 'git',
    b = { telescope('git_branches'),'branches'},
    c = { telescope('git_commits'),'commits'},
    f = { telescope('git_files'),'files'},
    s = { telescope('git_status'),'status'},
  },
  h = {
    name = 'help',
    h = { telescope('help_tags'),'topics'},
    m = { telescope('help_tags'),'man-pages'},
  },
  j = { telescope('jumplist'), 'jump lists'},
  k = { telescope('keymaps'), 'key maps'},
  l = {
    name = 'lsp',
    d = { telescope('lsp_definitions'),'definition'},
    i = { telescope('lsp_implementations'),'implementations'},
    r = { telescope('lsp_references'),'references'},
    t = { telescope('lsp_type_definitions'),'type'},
  },
  p = { 
    name = 'packer',
    c = {load_config .. command('PackerClean') .. echo('Packages Cleaned'),'clean'},
    s = {load_config .. command('PackerSync') .. echo('Pacakges Synced'),'sync'},
  },
  q = { command('q'),'quit'},
  r = { telescope('registers'),'registers'},
  t = { 
    name = 'tabs',
    c = { command('tabclose'),'close'},
    j = { command('tabprevious'),'previous'},
    k = { command('tabnext'),'next'},
    n = { command('tabnew'),'new'},
  },
  w = { 
    name = 'windows',
    c = { command('close'),'close'},
    h = {'<C-W><left>','left'},
    j = {'<C-W><down>','down'},
    k = {'<C-W><up>','up'},
    l = {'<C-W><right>','right'},
    s = { command('split') .. buffer_next,'split down'},
    v = { command('vsplit') .. buffer_next,'split right'},
    x = {
      name = 'resize',
      h = { command('vertical resize -5'),'left'},
      j = { command('resize -5'),'down'},
      k = { command('resize +5'),'up'},
      l = { command('vertical resize +5'),'right'},
    },
  },
  x = { command('q!'), 'force quit'},
}, 
{ prefix = '<leader>'}
);
