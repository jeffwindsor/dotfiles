return {
	src = "http://github.com/mcauley-penney/tidy.nvim",

	config = function()
		require("tidy").setup({
			enabled_on_save = false,
			filetype_exclude = { "markdown", "diff" },
		})

		-- keymaps
		vim.keymap.set("n", "<leader>tt", require("tidy").toggle, { desc = "Toggle Tidy" })
		vim.keymap.set("n", "<leader>tr", require("tidy").run, { desc = "Run Tidy" })
	end,
}
