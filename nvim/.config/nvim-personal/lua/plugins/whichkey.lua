return {
	src = "https://github.com/folke/which-key.nvim",
	lazy = { event = "VimEnter" },

	config = function()
		local wk = require("which-key")

		wk.setup({
			delay = 0,
			preset = "modern",
			plugins = {
				spelling = true,
			},
			win = {
				border = "single",
			},
		})

		-- Register group labels
		-- wk.add({
		-- 	{ "<leader>b", group = "buffer" },
		-- 	{ "<leader>f", group = "file" },
		-- 	{ "<leader>g", group = "git" },
		-- 	{ "<leader>p", group = "package" },
		-- 	{ "<leader>s", group = "search" },
		-- 	{ "<leader>w", group = "window" },
		-- })
	end,
}
