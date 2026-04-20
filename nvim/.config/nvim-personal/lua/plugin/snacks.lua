return {
	{
		src = "folke/snacks.nvim",
		lazy = { event = "VimEnter" },

		config = function()
			require("snacks").setup({
				dashboard = {
					enabled = false,
				},

				explorer = {
					replace_netrw = false,
				},

				picker = {
					sources = {
						explorer = {
							focus = "input",
							hidden = true,
							ignored = false,
						},

						grep = {
							hidden = true,
							ignored = true,
						},

						files = {
							hidden = true,
							ignored = true,
						},

						git_files = {
							untracked = true,
						},
					},
				},
			})
		end,
	},
}
