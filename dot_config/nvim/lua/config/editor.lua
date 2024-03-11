vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Nerd Font is installed
vim.g.have_nerd_font = true

-- Show line numbers as default
vim.opt.number = true
vim.opt.relativenumber = true

-- Don't wrap long lines
vim.opt.wrap = false

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Show a limiter ruler on the right
vim.opt.colorcolumn = "80"

-- Preview substitutions live on type
vim.opt.inccommand = "split"
vim.opt.incsearch = true

-- Sync clipboard between OS and Neovim
vim.opt.clipboard = 'unnamedplus'

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 12

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "cursor"

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Auto indentation when typing code blocks and etc
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Sets how neovim will display certain whitespace in the editor.
-- vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Save undo history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Define how files are encoded
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
