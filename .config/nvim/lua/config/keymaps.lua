-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--example
--map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
--
local map = vim.keymap.set

map("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "Toggle Zen Mode" })

-- map("n", "<leader>cf", "", { desc = "+format" })
map("n", "<leader>cfx", "<cmd>%!xmllint --format - <cr>", { desc = "Format XML" })
map("n", "<leader>cfs", "<cmd>%!shfmt - <cr>", { desc = "Format Shell" })

-- Open in external program
map("n", "<leader>o", "<cmd>!open %<cr>", { desc = "Open with default application" })

-- Search Dotfiles
map("n", "<leader>fd", '<cmd>FzfLua files cwd="$DOTFILES"<cr>', { desc = "Find dotfiles" })
map("n", "<leader>fN", '<cmd>FzfLua files cwd="$DOTFILES_NIX"<cr>', { desc = "Find nixos configs" })

-- Dashboard
map("n", "<leader>d", "<cmd>Dashboard<cr>", { desc = "Show Dashboard" })
