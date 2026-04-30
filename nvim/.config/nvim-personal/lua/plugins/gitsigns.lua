return {
	src = "https://github.com/lewis6991/gitsigns.nvim",
	lazy = { event = "BufReadPre" },

	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},

			signcolumn = true,
			numhl = false,
			linehl = false,

			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},

			current_line_blame = false,
		})
	end,
}
