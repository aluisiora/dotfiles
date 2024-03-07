local K = vim.keymap.set

return {
    general = function()
        K("n", "<leader>nn", vim.cmd.Ex, { desc = "[N]avigate to [N]etwr" })
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
        K("n", "<C-h>", "<C-w><C-h>", { desc = 'Move focus to the left window' })
        K("n", "<C-l>", "<C-w><C-l>", { desc = 'Move focus to the right window' })
        K("n", "<C-j>", "<C-w><C-j>", { desc = 'Move focus to the lower window' })
        K("n", "<C-k>", "<C-w><C-k>", { desc = 'Move focus to the upper window' })

        -- Prevent accidental quits
        K("n", "Q", "<nop>")

        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        K('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
        K('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
        K('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
        K('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
    end,
    telescope = function(builtin)
        K('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        K('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        K('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
        K('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
        K('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        K('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        K('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        K('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        K('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        K('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

        K('n', '<leader>/', function()
            local dropdown = require('telescope.themes').get_dropdown({
                winblend = 10,
                previewer = false,
            })
            builtin.current_buffer_fuzzy_find(dropdown)
        end, { desc = '[/] Fuzzily search in current buffer' })

        K('n', '<leader>s/', function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            })
        end, { desc = '[S]earch [/] in Open Files' })

        K('n', '<leader>sn', function()
            builtin.find_files({
                cwd = vim.fn.stdpath('config'),
            })
        end, { desc = '[S]earch [N]eovim files' })
    end,
    neo_tree = function()
        K("n", "<leader>ft", ":Neotree filesystem toggle left<CR>", {
            desc = "[F]ilesystem [T]oggle"
        })
    end,
    harpoon = function(h)
        K("n", "<leader>qa", h.append, { desc = "Harpoon: [Q]uick [A]ppend"})
        K("n", "<leader>qm", h.toggle_quick_menu, { desc = "Harpoon: [Q]uick [M]enu" })
        -- K("n", "<C-P>", h.jump_to_previous, {})
        -- K("n", "<C-N>", h.jump_to_next, {})
        -- K("n", "<C-1>", h.jump_to(1), {})
        -- K("n", "<C-2>", h.jump_to(2), {})
        -- K("n", "<C-3>", h.jump_to(3), {})
        -- K("n", "<C-4>", h.jump_to(4), {})
    end,
    lazygit = function()
        K("n", "<leader>gg", vim.cmd.LazyGit)
    end,
    none_ls = function()
        K("n", "<leader>cf", function()
            vim.lsp.buf.format({ async = true })
        end, { desc = "[C]ode [F]ormat" })
    end,
    undotree = function()
        K("n", "<leader>ut", vim.cmd.UndotreeToggle, {
            desc = '[U]ndo [T]oggle',
        })
    end,
    lsp = function(opts, builtin)
        local map = function(keys, func, desc)
            K('n', keys, func, { buffer = opts.buffer, desc = 'LSP: ' .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-T>.
        map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')

        -- Find references for the word under your cursor.
        map('gr', builtin.lsp_references, '[G]oto [R]eferences')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace
        --  Similar to document symbols, except searches over your whole project.
        map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- Rename the variable under your cursor
        --  Most Language Servers support renaming across files, etc.
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap
        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    end,
    coverage = function()
        K("n", "<leader>tcs", ":Coverage<CR>", { desc = "[T]est [C]overage [S]how"})
        K("n", "<leader>tch", ":CoverageClear<CR>", { desc = "[T]est [C]overage [H]ide"})
        K("n", "<leader>tcr", ":CoverageSummary<CR>", { desc = "[T]est [C]overage [R]eport"})
    end,
    debugger = function(dap, dapui)
        K('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
        K('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
        K('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
        K('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
        K('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
        K('n', '<leader>B', function()
            dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end, { desc = 'Debug: Set Breakpoint' })

        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        K('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
        --
        -- K("n", "<leader>dk", dap.toggle_breakpoint, {})
        -- K("n", "<leader>dc", dap.continue, {})
    end,
    go_debugger = function(dap)
        K("n", "<leader>dt", dap.debug_test, { desc = "GO: [D]ebug [T]est"})
    end,
}
