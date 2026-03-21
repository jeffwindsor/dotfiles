return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- use latest release, remove to use latest commit
	ft = "markdown",
	keys = {
		{ "<leader>o", "<cmd>Obsidian<CR>", desc = "Obsidian" },
		{ "<leader>ob", "<cmd>Obsidian backlinks<CR>", desc = "Show backlinks" },
		{ "<leader>oT", "<cmd>Obsidian tags<CR>", desc = "Search tags" },
		{ "<leader>ol", "<cmd>Obsidian links<CR>", desc = "Show links" },
		{ "<leader>on", "<cmd>Obsidian new<CR>", desc = "New" },
		{ "<leader>oq", "<cmd>Obsidian quick-switch<CR>", desc = "Quick switch" },
		{ "<leader>or", "<cmd>Obsidian rename<CR>", desc = "Rename" },
		{ "<leader>oo", "<cmd>Obsidian search<CR>", desc = "Search" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"saghen/blink.cmp",
	},
	opts = {
		-- Specify vault location (required)
		workspaces = {
			{
				name = "default",
				path = "~/markdown",
			},
		},

		-- PARA-specific: store images in attachments/ instead of default assets/imgs/
		attachments = {
			img_folder = "attachments",
		},

		-- macOS-specific: use 'open' command instead of default xdg-open (Linux)
		follow_url_func = function(url)
			vim.fn.jobstart({ "open", url })
		end,
	},
}
