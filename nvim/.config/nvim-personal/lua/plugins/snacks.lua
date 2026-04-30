return {
	src = "https://github.com/folke/snacks.nvim",
	lazy = { event = "VimEnter" },

	config = function()
		local snacks = require("snacks")

		snacks.setup({
			dashboard = { enabled = false },
			input = { enabled = true },
			lazygit = { enabled = true },
			notifier = { enabled = true },
			picker = {
				enabled = true,
				sources = {
					explorer = {
						focus = "input",
						hidden = true,
						ignored = false,
					},
					grep = {
						hidden = true,
						ignored = true,
					},
					files = {
						hidden = true,
						ignored = true,
					},
					git_files = {
						untracked = true,
					},
				},
			},
		})

		-- Package-Specific Keybindings
		local map = vim.keymap.set

		-- Top Level Search & Navigation
		map("n", "<leader><space>", function()
			snacks.picker.files()
		end, { desc = "Find Files (Root Dir)" })
		map("n", "<leader>/", function()
			snacks.picker.grep()
		end, { desc = "Grep (Root Dir)" })
		map("n", "<leader>,", function()
			snacks.picker.buffers()
		end, { desc = "Buffers" })
		map("n", "<leader>:", function()
			snacks.picker.command_history()
		end, { desc = "Command History" })

		-- Search Group (<leader>s)
		map("n", "<leader>sb", function()
			snacks.picker.lines()
		end, { desc = "Buffer Lines" })
		map("n", "<leader>sd", function()
			snacks.picker.diagnostics()
		end, { desc = "Diagnostics" })
		map("n", "<leader>sk", function()
			snacks.picker.keymaps()
		end, { desc = "Keymaps" })
		map("n", "<leader>sq", function()
			snacks.picker.qflist()
		end, { desc = "Quickfix List" })

		-- File Group (<leader>f)
		map("n", "<leader>fF", function()
			snacks.picker.files({ cwd = vim.fn.getcwd() })
		end, { desc = "Find Files (cwd)" })
		map("n", "<leader>fg", function()
			snacks.picker.git_files()
		end, { desc = "Find Git Files" })
		map("n", "<leader>fe", function()
			snacks.explorer()
		end, { desc = "Explorer" })

		-- Git Group (<leader>g)
		map("n", "<leader>gg", function()
			snacks.lazygit()
		end, { desc = "LazyGit" })
		map("n", "<leader>gl", function()
			snacks.picker.git_log()
		end, { desc = "Git Log" })
		map("n", "<leader>gs", function()
			snacks.picker.git_status()
		end, { desc = "Git Status" })

		-- Window Management (Part of Snacks logic or standard)
		map("n", "<leader>bd", function()
			snacks.bufdelete()
		end, { desc = "Delete Buffer" })
	end,
}
