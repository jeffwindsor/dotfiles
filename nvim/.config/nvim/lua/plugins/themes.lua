-- lazy = false, -- Make sure to load this during startup
-- priority = 1000, -- Make sure it loads before other start plugins

-- previous
-- { "oxfist/night-owl.nvim", lazy = false, priority = 1000 },
-- { "jacoborus/tender.vim", lazy = false, priority = 1000 },
-- { "marko-cerovac/material.nvim", lazy = false, priority = 1000 },
-- { "ribru17/bamboo.nvim", opts = { theme = "multiplex" }, lazy = false, priority = 1000 },
-- { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
-- { "vague-theme/vague.nvim" },

return {
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		opts = { options = { dim_inactive = true } },
		-- config = function(_, opts)
		-- 	require("nightfox").setup(opts)
		-- 	vim.cmd.colorscheme("duskfox")
		-- 	vim.cmd.highlight({ "WinSeparator", "guifg=#54546d" })
		-- end,
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
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = {},
			statementStyle = { bold = true },
		},
	},
	{ "savq/melange-nvim" },
	{ "sainnhe/everforest" },
	{ "navarasu/onedark.nvim" },
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "melange",
		},
	},
}
