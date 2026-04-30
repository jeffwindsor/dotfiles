return {
	src = "https://github.com/0x00-ketsu/autosave.nvim",
	config = function()
		require("autosave").setup({
			events = { "InsertLeave", "TextChanged", "FocusLost", "BufLeave" },
			debounce_delay = 1000,
		})
	end,
}
