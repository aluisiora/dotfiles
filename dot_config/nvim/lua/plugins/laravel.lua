return {
	"adalessa/laravel.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"tpope/vim-dotenv",
		"MunifTanjim/nui.nvim",
		"nvimtools/none-ls.nvim",
	},
	cmd = { "Sail", "Artisan", "Composer", "Npm", "Laravel" },
	keys = {},
	event = { "VeryLazy" },
	config = function()
		require("keymaps").laravel()
	end,
}

