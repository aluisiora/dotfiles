return {
	"nvimtools/none-ls.nvim",
	config = function()
		local none_ls = require("null-ls")
		none_ls.setup({
			sources = {
				none_ls.builtins.formatting.stylua,
				-- PHP
				none_ls.builtins.formatting.phpcsfixer,
				none_ls.builtins.diagnostics.phpstan,
				-- Javacript
				none_ls.builtins.formatting.prettier,
				none_ls.builtins.diagnostics.eslint,
			},
		})
    require("keymaps").none_ls()
	end,
}
