return {
	{
		"nvim-mini/mini.nvim",
		version = "*",
		config = function()
			require("mini.hues").setup({
				background = "#1d2231",
				foreground = "#c4c6cd",
			})
		end,
	},
}
