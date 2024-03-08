return {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
        require('which-key').setup()

        -- Document existing key chains
        require('which-key').register {
            ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
            ['<leader>f'] = { name = '[F]ile', _ = 'which_key_ignore' },
            ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
            ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
            ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
            ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
            ['<leader>t'] = { name = '[T]est', _ = 'which_key_ignore' },
            ['<leader>g'] = { name = '[G]oto', _ = 'which_key_ignore' },
            ['<leader>u'] = { name = '[U]ndo', _ = 'which_key_ignore' },
            ['<leader>q'] = { name = '[Q]uick', _ = 'which_key_ignore' },
            ['<leader>o'] = { name = '[O]pen', _ = 'which_key_ignore' },
        }
    end,
}
