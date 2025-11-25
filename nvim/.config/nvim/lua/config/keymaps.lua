-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Sort selection
vim.keymap.set("v", "<leader><Down>", ":sort<cr>", { desc = "Sort Selection" })
vim.keymap.set("v", "<leader><Up>", ":sort!<cr>", { desc = "Sort Selection Reversed" })

-- Remove all default <leader>q keybindings
vim.keymap.del("n", "<leader>qq")
vim.keymap.del("n", "<leader>qs")
vim.keymap.del("n", "<leader>qS")
vim.keymap.del("n", "<leader>ql")
vim.keymap.del("n", "<leader>qd")

-- Set <leader>q to quit all and <leader>Q to force quit all
vim.keymap.set("n", "<leader>q", ":qa<cr>", { desc = "Quit All" })
vim.keymap.set("n", "<leader>Q", ":qa!<cr>", { desc = "Force Quit All" })

-- Set <leader>C to Colorschemes
vim.keymap.set("n", "<leader>C", function()
	Snacks.picker.colorschemes()
end, { desc = "Colorschemes" })
