return {
	"0x00-ketsu/autosave.nvim",
	event = { "InsertLeave", "TextChanged", "FocusLost", "BufLeave" },
	config = function()
		require("autosave").setup({
			events = { "InsertLeave", "TextChanged", "FocusLost", "BufLeave" },
			debounce_delay = 1000,
		})
	end,
}
