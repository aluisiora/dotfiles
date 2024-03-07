return {
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                local opts = { buffer = bufnr }
                lsp_zero.default_keymaps(opts)
                require("keymaps").lsp(opts, require('telescope.builtin'))
            end)

            -- technically these are "diagnostic signs"
            -- neovim enables them by default.
            -- here we are just changing them to fancy icons.
            lsp_zero.set_sign_icons({
                error = "✘",
                warn = "▲",
                hint = "⚑",
                info = "»",
            })

            -- to learn how to use mason.nvim with lsp-zero
            -- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls" },
                automatic_installation = true,
                handlers = {
                    lsp_zero.default_setup,
                },
            })

            local cmp = require("cmp")
            local cmp_action = lsp_zero.cmp_action()

            -- this is the function that loads the extra snippets
            -- from rafamadriz/friendly-snippets
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                -- if you don't know what is a "source" in nvim-cmp read this:
                -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/autocomplete.md#adding-a-source
                sources = {
                    { name = "path" },
                    { name = "nvim_lsp" },
                    { name = "luasnip", keyword_length = 2 },
                    { name = "buffer",  keyword_length = 3 },
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                -- default keybindings for nvim-cmp are here:
                -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/README.md#keybindings-1
                mapping = cmp.mapping.preset.insert({
                    -- confirm completion item
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),

                    -- trigger completion menu
                    ["<C-Space>"] = cmp.mapping.complete(),

                    -- scroll up and down the documentation window
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),

                    -- navigate between snippet placeholders
                    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                    ["<C-b>"] = cmp_action.luasnip_jump_backward(),
                }),
                -- note: if you are going to use lsp-kind (another plugin)
                -- replace the line below with the function from lsp-kind
                formatting = lsp_zero.cmp_format(),
            })
        end,
    },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/nvim-cmp" },
    { "L3MON4D3/LuaSnip" },
}
