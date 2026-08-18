return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',

	config = function()
		local treesitter = require("nvim-treesitter")
		treesitter.setup({
			ensure_installed = {
				"bash",
				"c",
				"css",
				"html",
				"javascript",
				"lua",
				"markdown",
				"python", 
				"query",
				"toml",
				"typescript",
				"vim",
				"vimdoc",
				"yaml"
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
		})
	end,
}
