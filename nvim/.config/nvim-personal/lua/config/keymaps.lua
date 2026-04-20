-- General Actions
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clears search highlights" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Leader Actions
vim.keymap.set("n", "<leader>p", "", { desc = "Packages" })
vim.keymap.set("n", "<leader>pu", ":lua vim.pack.update()<cr>", { desc = "Update All packages" })
vim.keymap.set("n", "<leader>Q", ":qa!<cr>", { desc = "Force Quit All" })
vim.keymap.set("n", "<leader>q", ":qa<cr>", { desc = "Quit All" })
vim.keymap.set("v", "<leader>s<Down>", ":sort<cr>", { desc = "Sort Selection" })
vim.keymap.set("v", "<leader>s<Up>", ":sort!<cr>", { desc = "Sort Selection Reversed" })
