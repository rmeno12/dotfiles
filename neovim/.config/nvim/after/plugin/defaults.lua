vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true -- colors in terminal
vim.opt.hlsearch = true -- highlight on search
vim.opt.number = true -- turn on line numbers
vim.opt.mouse = "a" -- enable mouse
vim.opt.breakindent = true
vim.opt.undofile = true -- save undo history
vim.opt.ignorecase = true -- ignore case in search
vim.opt.smartcase = true -- don't ignore case if there are capital letters
vim.opt.updatetime = 50 -- update time 50ms
vim.opt.signcolumn = "yes" -- always show sign column
vim.opt.timeoutlen = 300 -- timeoutlen to 300ms (for which-key)
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]
