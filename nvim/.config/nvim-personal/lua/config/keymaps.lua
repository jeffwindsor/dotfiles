local map = vim.keymap.set

map("n", "<leader>Q", ":qa!<cr>", { desc = "Force Quit All" })
map("n", "<leader>q", ":qa<cr>", { desc = "Quit All" })

-- buffers
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>b", "", { desc = "buffer" })
map("n", "<leader>b[", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<leader>b[", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<leader>b]", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function()
	Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })

-- packages
map("n", "<leader>p", "", { desc = "package" })
map("n", "<leader>pu", ":lua vim.pack.update()<cr>", { desc = "Update All packages" })

-- windows
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
map("n", "<leader>-", "<cmd>split<cr>", { desc = "Split Window Below" })
map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split Window Right" })
map("n", "<leader>w", "", { desc = "window" })
map("n", "<leader>wd", "<cmd>close<cr>", { desc = "Delete Window" })

-- misc
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clears search highlights" })
map("v", "<leader><Down>", ":sort i<cr>", { desc = "Sort Selection" })
map("v", "<leader><Up>", ":sort! i<cr>", { desc = "Sort Selection Reversed" })
map("x", "<", "<gv", { desc = "Indent Left" })
map("x", ">", ">gv", { desc = "Indent Right" })
