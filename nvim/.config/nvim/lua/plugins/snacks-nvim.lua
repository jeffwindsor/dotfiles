return {
	"folke/snacks.nvim",
	opts = {
		dashboard = { enabled = false },
		-- Using an auto command to open the file picker instead of netrw
		explorer = { replace_netrw = false },
		picker = {
			sources = {
				explorer = { focus = "input", hidden = true, ignored = false },
				grep = { hidden = true, ignored = false },
				files = { hidden = true, ignored = false },
				git_files = { untracked = true },
			},
		},
	},
}
