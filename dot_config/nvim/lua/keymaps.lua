local K = vim.keymap.set

return {
    general = function()
        vim.g.mapleader = " "
        K("n", "<leader>nn", vim.cmd.Ex)
        K("n", "x", '"_x')

        -- Increment/decrement numbers
        K("n", "+", "<C-a>")
        K("n", "-", "<C-x>")

        -- Move selected lines up and down
        K("v", "J", ":m '>+1<CR>gv=gv")
        K("v", "K", ":m '<-2<CR>gv=gv")

        -- Pg up, pg down and searches with cursor in place
        K("n", "<C-d>", "<C-d>zz")
        K("n", "<C-u>", "<C-u>zz")
        K("n", "n", "nzzzv")
        K("n", "N", "Nzzzv")

        -- Paste without losing clipboard info
        K("x", "<leader>p", "\"_dP")

        -- Split navigation
        K("n", "<leader>h", "<C-w>h")
        K("n", "<leader>l", "<C-w>l")
        K("n", "<leader>j", "<C-w>j")
        K("n", "<leader>k", "<C-w>k")
        K("n", "<leader>|", "<C-w>v")
        K("n", "<leader>_", "<C-w>s")

        -- Split resizing
        K("n", "<leader>H", "<C-w><")
        K("n", "<leader>J", "<C-w>-")
        K("n", "<leader>K", "<C-w>+")
        K("n", "<leader>L", "<C-w>>")

        -- ESC remapping
        K("n", "<C-c>", "<Esc>")
        K("n", "<C-q>", "<Esc>")

        K("n", "Q", "<nop>")

        -- K("n", "<leader>npj", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
    end,
    telescope = function(m)
        K("n", "<leader> ", m.find_files, {})
        K("n", "<leader>g ", m.git_files, {})
        K("n", "<leader>f ", m.live_grep, {})
        K("n", "<leader>b ", m.buffers, {})
    end,
    neo_tree = function()
        K("n", "<leader>bb", ":Neotree filesystem toggle left<CR>")
    end,
    harpoon = function(h)
        K("n", "<leader>qa", h.append, {})
        K("n", "<leader>qq", h.toggle_quick_menu, {})
        K("n", "<leader>qp", h.jump_to_previous, {})
        K("n", "<leader>qn", h.jump_to_next, {})
        K("n", "<leader>1", h.jump_to(1), {})
        K("n", "<leader>2", h.jump_to(2), {})
        K("n", "<leader>3", h.jump_to(3), {})
        K("n", "<leader>4", h.jump_to(4), {})
    end,
    lazygit = function()
        K("n", "<leader>gg", vim.cmd.LazyGit)
    end,
    none_ls = function()
        -- K("n", "<leader>ff", vim.lsp.buf.format, {})
    end,
    undotree = function()
        K("n", "<leader>uu", vim.cmd.UndotreeToggle)
    end,
    lsp = function(opts)
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        K("n", "<leader>vd", vim.diagnostic.open_float)
        K("n", "]d", vim.diagnostic.goto_prev)
        K("n", "[d", vim.diagnostic.goto_next)
        -- K("n", "<leader>oq", vim.diagnostic.setloclist)

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        K("n", "gD", vim.lsp.buf.declaration, opts)
        K("n", "gd", vim.lsp.buf.definition, opts)
        K("n", "K", vim.lsp.buf.hover, opts)
        K("n", "gi", vim.lsp.buf.implementation, opts)
        K("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        K("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
        K("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
        K("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        K("n", "<leader>D", vim.lsp.buf.type_definition, opts)
        K("n", "<leader>rn", vim.lsp.buf.rename, opts)
        K({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        K("n", "gr", vim.lsp.buf.references, opts)
        K("n", "<leader>ff", function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end,
    coverage = function()
        K("n", "<leader>tc", ":Coverage<CR>")
    end,
    debugger = function(dap)
        K("n", "<leader>dt", dap.toggle_breakpoint, {})
        K("n", "<leader>dc", dap.continue, {})
    end,
}
