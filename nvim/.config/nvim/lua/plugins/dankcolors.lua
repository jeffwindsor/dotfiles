return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#15130c',
				base01 = '#15130c',
				base02 = '#89887f',
				base03 = '#89887f',
				base04 = '#dedcd1',
				base05 = '#fffef8',
				base06 = '#fffef8',
				base07 = '#fffef8',
				base08 = '#ffa99f',
				base09 = '#ffa99f',
				base0A = '#e9dd8c',
				base0B = '#b0fea5',
				base0C = '#fff8c9',
				base0D = '#e9dd8c',
				base0E = '#fff4ab',
				base0F = '#fff4ab',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#89887f',
				fg = '#fffef8',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#e9dd8c',
				fg = '#15130c',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#89887f' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#fff8c9', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#fff4ab',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#e9dd8c',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#e9dd8c',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#fff8c9',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#b0fea5',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#dedcd1' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#dedcd1' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#89887f',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
