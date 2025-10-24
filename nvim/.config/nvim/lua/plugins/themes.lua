-- lazy = false, -- Make sure to load this during startup
-- priority = 1000, -- Make sure it loads before other start plugins

return {
	{
		"oxfist/night-owl.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			bold = true,
			italics = false,
			underline = true,
			undercurl = true,
			transparent_background = false,
		},
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			theme = "wave", -- "wave", "dragon", "lotus"
			transparent = false,
			undercurl = true,
			dimInactive = true,
			-- Style predicates: bold, italic, underline, undercurl,
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = {},
			statementStyle = { bold = true },
		},
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			styles = {
				comments = "italic",
				keywords = "bold",
				types = "italic,bold",
			},
		},
	},
}
