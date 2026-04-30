local PLUGIN_DIR = vim.fn.stdpath("config") .. "/lua/plugins"

vim.api.nvim_create_user_command("PackStatus", function()
	for _, file in ipairs(vim.fn.globpath(PLUGIN_DIR, "*.lua", false, true)) do
		print("- " .. vim.fn.fnamemodify(file, ":t:r"))
	end
end, {})

local function plugin_specs()
	local plugins = {}
	for _, file in ipairs(vim.fn.globpath(PLUGIN_DIR, "*.lua", false, true)) do
		local ok, spec = pcall(dofile, file)
		if ok and type(spec) == "table" and type(spec.src) == "string" then
			table.insert(plugins, spec)
		end
	end
	return plugins
end

-- Execute the load immediately
vim.pack.add(plugin_specs())
