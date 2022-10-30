
local wk = require('which-key')

wk.setup()
wk.register({
  b = { 
    name = 'buffers',
    b = {'<Cmd>Telescope buffers<CR>','buffers'},
    c = {'<Cmd>bdelete<CR>','close'},
    j = {'<Cmd>bprevious<CR>','previous'},
    k = {'<Cmd>bnext<CR>','next'},
    n = {'<Cmd>enew<CR>','new'},
  },
  c = {
    name = 'commands and colors',
    c = {'<Cmd>Telescope commands<CR>','commands'},
    d = {'<Cmd>set background=dark<CR>','dark theme version'},
    l = {'<Cmd>set background=light<CR>','light theme version'},
    h = {'<Cmd>Telescope command_history<CR>','command history'},
    s = {'<Cmd>Telescope colorscheme<CR>','color schemes'},
  },
  f = { 
    name = 'files',
    b = {'<Cmd>Telescope file_browser<CR>','browse'},
    c = {'<Cmd>Telescope find_files cwd=$XDG_CONFIG_HOME<CR>','config'},
    d = {'<Cmd>Telescope find_files cwd=$DOTFILES<CR>','dots'},
    f = {'<Cmd>Telescope find_files<CR>','files'},
    h = {'<Cmd>Telescope find_files cwd=$HOME<CR>','home'},
    i = {'<Cmd>Telescope find_files cwd=$INSTALLS<CR>','installs'},
    s = {'<Cmd>Telescope find_files cwd=$SRC<CR>','sources'},
    t = {'<Cmd>Telescope filetypes<CR>','file types'},
  },
  g = { 
    name = 'git',
    b = {'<Cmd>Telescope git_branches<CR>','git branches'},
    c = {'<Cmd>Telescope git_commits<CR>','git commits'},
    f = {'<Cmd>Telescope git_files<CR>','git files'},
    g = {'<Cmd>Telescope git_files<CR>','lazy git'},
    s = {'<Cmd>Telescope git_status<CR>','git status results'},
  },
  h = {
    name = 'help',
    h = {'<Cmd>Telescope help_tags<CR>','help topics'},
    m = {'<Cmd>Telescope help_tags<CR>','man-pages'},
  },
  p = { 
    name = 'packer',
    c = {'<Cmd>luafile %<CR><Cmd>PackerClean<CR>','clean'},
    s = {'<Cmd>luafile %<CR><Cmd>PackerSync<CR>','sync'},
  },
  q = {'<Cmd>q<CR>','quit'},
  r = {'<Cmd>luafile %<CR>','reload config'},
  s = { 
    name = 'search',
    g = {'<Cmd>Telescope live_grep<CR>','file contents (grep)'},
    r = {'<Cmd>Telescope registers<CR>','registers'},
  },
  t = { 
    name = 'tab',
    c = {'<Cmd>tabclose<CR>','close'},
    j = {'<Cmd>tabprevious<CR>','previous'},
    k = {'<Cmd>tabnext<CR>','next'},
    n = {'<Cmd>tabnew<CR>','new'},
  },
  w = { 
    name = 'window',
    c = {'<Cmd>close<CR>','close'},
    h = {'<C-W><left>','left'},
    j = {'<C-W><down>','down'},
    k = {'<C-W><up>','up'},
    l = {'<C-W><right>','right'},
    s = {'<Cmd>split<CR><Cmd>bnext<CR>','split down'},
    v = {'<Cmd>vsplit<CR><Cmd>bnext<CR>','split right'},
    x = {
      name = 'resize',
      h = {'<Cmd>vertical resize -5<CR>','left'},
      j = {'<Cmd>resize -5<CR>','down'},
      k = {'<Cmd>resize +5<CR>','up'},
      l = {'<Cmd>vertical resize +5<CR>','right'},
    },
  },
  x = {'<Cmd>q!<CR>', 'quit (no warning)'},
}, 
{ prefix = '<leader>'}
);
