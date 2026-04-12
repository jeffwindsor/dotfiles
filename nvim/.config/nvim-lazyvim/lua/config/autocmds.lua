-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- use file picker not explorer
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(ev)
		local buf_path = vim.fn.expand("%")
		if vim.fn.isdirectory(buf_path) == 1 then
			vim.schedule(function()
				-- make directory the root
				vim.cmd.cd(vim.fn.fnameescape(buf_path))
				-- delete the directory buffer using snacks
				require("snacks").bufdelete.delete(ev.buf)
				-- open the file picker
				require("snacks").picker.files()
			end)
		end
	end,
})
