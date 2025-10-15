-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- when nvim is opened with a directory, use dir as root then open the file picker
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local args = vim.fn.argv()
		if #args > 0 then
			local arg = args[1]
			if vim.fn.isdirectory(arg) == 1 then
				-- The vim.schedule() wrapper ensures the picker opens after Neovim fully initializes
				vim.schedule(function()
					-- make directory the root
					vim.cmd.cd(vim.fn.fnameescape(arg))
					-- open a file picker in that directory
					require("snacks").picker.files()
				end)
			end
		end
	end,
})
