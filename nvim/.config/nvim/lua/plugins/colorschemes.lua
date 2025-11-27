local favorite_colorschemes = {
	"onedark",
	"everforest",
	"kanagawa",
	"duskfox",
	"melange",
	"catppuccin-frappe",
	"tokyonight",
}

local function apply_random_favorite_colorscheme()
	-- Filter to installed-only schemes
	local available = {}
	for _, name in ipairs(favorite_colorschemes) do
		if pcall(vim.cmd.colorscheme, name) then
			table.insert(available, name)
		end
	end

	if #available == 0 then
		vim.notify("No colorschemes from your list are installed!", vim.log.levels.ERROR)
		return
	end

	-- Randomize
	math.randomseed(os.time())
	local choice = available[math.random(#available)]

	-- Apply
	vim.cmd.colorscheme(choice)

	-- Notify
	vim.notify("Colorscheme: " .. choice, vim.log.levels.INFO)
end

return {
	{ "EdenEast/nightfox.nvim", opts = { options = { dim_inactive = true } } },
	{ "rebelot/kanagawa.nvim", opts = { theme = "wave" } },
	{ "savq/melange-nvim" },
	{ "sainnhe/everforest" },
	{ "navarasu/onedark.nvim" },
	{
		name = "apply-random-favorite-colorscheme-on-load",
		lazy = false,
		priority = 1000,
		config = apply_random_favorite_colorscheme(),
	},
}

-- previously interesting colroschemes
-- { "oxfist/night-owl.nvim"},
-- { "jacoborus/tender.vim"},
-- { "marko-cerovac/material.nvim"},
-- { "catppuccin/nvim", name = "catppuccin"},
-- { "vague-theme/vague.nvim" },
