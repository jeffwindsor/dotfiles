-- prepend action with telescope. example = <Cmd>Telescope action<CR>
function telescope(action)
  return command('Telescope ' .. action)
end

-- wraps action in a vim command.  example = <Cmd>action<CR> which is the same as :action<CR>
function command(action)
  return '<Cmd>' .. action .. '<CR>'
end

local buffer_next = command('buffernext')
local load_config = command('luafile %')

local wk = require('which-key')
wk.setup()
wk.register({
  ["<leader>"] = { telescope('find_files'), 'find files'},
  ["."] = { load_config, 'load config'}, 
  [","] = { 
    name = 'commands',
    [","] = {telescope('commands'),'commands'},
    h = {telescope('command_history'),'history'},
  },
  b = { 
    name = 'buffers',
    b = {telescope('buffers'),'buffers'},
    c = {command('bdelete'),'close'},
    j = {command('bprevious'),'previous'},
    k = {buffer_next,'next'},
    n = {command('enew'),'new'},
  },
  c = {
    name = 'color schemes',
    c = {command('colorscheme'),'color schemes'},
    d = {command('set background=dark'),'dark'},
    l = {command('set background=light'),'light'},
  },
  f = { 
    name = 'files',
    b = {telescope('file_browser'),'via browser'},
    c = {telescope('find_files cwd=$XDG_CONFIG_HOME'),'in config directory'},
    d = {telescope('find_files cwd=$DOTFILES'),'in dotfiles directory'},
    f = {telescope('find_files'),'in current directory'},
    h = {telescope('find_files cwd=$HOME'),'in home directory'},
    i = {telescope('find_files cwd=$INSTALLS'),'in install files directory'},
    p = {telescope('project_files'),'in project'},
    s = {telescope('find_files cwd=$SRC'),'in git repos'},
    t = {telescope('filetypes'),'set file type'},
  },
  g = { 
    name = 'git',
    b = {telescope('git_branches'),'branches'},
    c = {telescope('git_commits'),'commits'},
    f = {telescope('git_files'),'files'},
    g = {telescope('git_files'),'lazy git'},
    s = {telescope('git_status'),'status'},
  },
  h = {
    name = 'help',
    h = {telescope('help_tags'),'topics'},
    m = {telescope('help_tags'),'man-pages'},
  },
  p = { 
    name = 'packer',
    c = {load_config .. command('PackerClean'),'clean'},
    s = {load_config .. command('PackerSync'),'sync'},
  },
  q = {command('q'),'quit'},
  r = {telescope('registers'),'registers'},
  s = {telescope('live_grep'),'search (grep)'},
  t = { 
    name = 'tabs',
    c = {command('tabclose'),'close'},
    j = {command('tabprevious'),'previous'},
    k = {command('tabnext'),'next'},
    n = {command('tabnew'),'new'},
  },
  w = { 
    name = 'windows',
    c = {command('close'),'close'},
    h = {'<C-W><left>','left'},
    j = {'<C-W><down>','down'},
    k = {'<C-W><up>','up'},
    l = {'<C-W><right>','right'},
    s = {command('split') .. buffer_next,'split down'},
    v = {command('vsplit') .. buffer_next,'split right'},
    x = {
      name = 'resize',
      h = {command('vertical resize -5'),'left'},
      j = {command('resize -5'),'down'},
      k = {command('resize +5'),'up'},
      l = {command('vertical resize +5'),'right'},
    },
  },
  x = {command('q!'), 'force quit'},
}, 
{ prefix = '<leader>'}
);
