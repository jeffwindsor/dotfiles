return {
	src = "https://github.com/echasnovski/mini.hipatterns",
	lazy = { event = "BufReadPost" },

	config = function()
		local hipatterns = require("mini.hipatterns")

		hipatterns.setup({
			highlighters = {
				-- hex colors like #aabbcc
				hex_color = hipatterns.gen_highlighter.hex_color(),

				-- TODO/FIXME/NOTE highlights
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "ErrorMsg" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "Todo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "DiagnosticHint" },
			},
		})
	end,
}
