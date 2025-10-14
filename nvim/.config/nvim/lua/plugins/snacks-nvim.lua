return {
	"folke/snacks.nvim",
	opts = {
		dashboard = { enabled = false },
		explorer = { files = { hidden = true } },
		-- puts the explorer cursor in the search box
		picker = { sources = { explorer = { focus = "input" } } },
	},
}
