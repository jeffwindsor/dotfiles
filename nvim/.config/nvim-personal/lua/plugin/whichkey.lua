return {
	{
		src = "folke/which-key.nvim",
		lazy = { event = "VimEnter" },

		config = function()
			require("which-key").setup({
				delay = 0,
				preset = "modern",

				plugins = {
					spelling = true,
				},

				win = {
					border = "single",
				},
			})
		end,
	},
}
