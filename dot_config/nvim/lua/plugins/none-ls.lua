return {
	"nvimtools/none-ls.nvim",
	config = function()
		local none_ls = require("null-ls")
		none_ls.setup({
			sources = {
				none_ls.builtins.formatting.stylua,
				-- Javacript
				none_ls.builtins.formatting.prettier,
				-- PHP
				none_ls.builtins.formatting.phpcsfixer.with({
					prefer_local = "vendor/bin/php-cs-fixer"
				}),
				none_ls.builtins.diagnostics.phpstan.with({
					temp_dir = "/tmp",
					prefer_local = "vendor/bin/phpstan",
					method = none_ls.methods.DIAGNOSTICS_ON_SAVE,
				}),
			},
		})
    require("keymaps").none_ls()
	end,
}
