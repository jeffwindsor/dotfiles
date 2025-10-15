return {
	"folke/snacks.nvim",
	opts = {
		dashboard = { enabled = false },
		explorer = { files = { hidden = true } },
		picker = {
			sources = {
				-- puts the explorer cursor in the search box
				explorer = { focus = "input" },
				-- Show hidden files in file pickers
				files = { hidden = true },
				git_files = { untracked = true },
			},
		},
	},
}
