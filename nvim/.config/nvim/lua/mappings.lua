--
-- Location of all non leader based mappings
-- Leader based have been moved tothe which key config in plugins
--
-- makes "action" a VIM command.  example = <Cmd>action<CR> which is the same as :action<CR>
local function command(action)
  return '<Cmd>' .. action .. '<CR>'
end

-- vim keymap function
local keymap     = vim.api.nvim_set_keymap

-- protects from remapping by other configs
local noremap = { noremap = true }

-- silent does not show bound command in bottom row / command output
local silent  = { noremap = true, silent = true }


-------------------------------------------------------------------------------
-- home row improvements
-------------------------------------------------------------------------------

-- quick <jk> produces an <escape> while in insert mode
keymap('i', 'jk', '<ESC>', silent)   

-- buffer movement direct from CONTROL
--   left / right for tabs 
keymap("n", "<C-h>", "tabprev", silent)
keymap("n", "<C-l>", "tabnext", silent)
--   up / down for buffers
keymap("n", "<C-j>", "bprev", silent)
keymap("n", "<C-k>", "bnext", silent)

-- first character in line
keymap("n", "H", "^", silent)

-- last character in line
keymap("n", "L", "$", silent)

-- return remove highlights
keymap("n", "<CR>", ":noh<CR><CR>", silent)

-------------------------------------------------------------------------------
-- muscle memory improvements
-------------------------------------------------------------------------------

-- command mode without the shift key (normal and visual mode)
keymap('n', ';', ':', noremap)
keymap('v', ';', ':', noremap)

-- yank acts like other capitol letters (normal mode)
keymap('n', 'Y', 'y$', noremap)


