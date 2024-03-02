return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require('telescope').setup({
                defaults = {
                    file_ignore_patterns = {
                        "node_modules/",
                        "vendor/",
                    },
                },
            })
            local builtin = require("telescope.builtin")
            require("keymaps").telescope(builtin)
        end,
    },
}
