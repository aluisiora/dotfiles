return {
    {
        "nvim-telescope/telescope.nvim",
        event = 'VimEnter',
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            'nvim-telescope/telescope-ui-select.nvim',
            {
                'nvim-tree/nvim-web-devicons',
                enabled = vim.g.have_nerd_font,
            },
        },
        config = function()
            local telescope = require('telescope')

            telescope.setup({
                defaults = {
                    file_ignore_patterns = {
                        "node_modules/",
                        "vendor/",
                    },
                },
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
            })

            pcall(telescope.load_extension, 'fzf')
            pcall(telescope.load_extension, 'ui-select')

            local builtin = require("telescope.builtin")
            require("keymaps").telescope(builtin)
        end,
    },
}
