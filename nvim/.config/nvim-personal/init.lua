require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Load Plugins
local function plugins_as_vim_pack_adds()
	local plugins = {}
	local dir = vim.fn.stdpath("config") .. "/lua/plugin"

	for _, file in ipairs(vim.fn.globpath(dir, "*.lua", false, true)) do
		local ok, spec = pcall(dofile, file)

		if not ok then
			vim.notify("Error loading plugin file: " .. file, vim.log.levels.ERROR)
		elseif type(spec) ~= "table" then
			vim.notify("Invalid spec (not a table): " .. file, vim.log.levels.ERROR)
		elseif type(spec.src) ~= "string" or spec.src == "" then
			vim.notify("Missing/invalid 'src' in plugin file: " .. file, vim.log.levels.ERROR)
		else
			plugins[#plugins + 1] = spec
		end
	end

	return plugins
end

vim.pack.add(plugins_as_vim_pack_adds())
