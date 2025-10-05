-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.signcolumn = "yes"

vim.opt.mouse = "a"

vim.opt.confirm = true

vim.opt.listchars = {
    tab = "> ",
    trail = "-",
    extends = "…",
    precedes = "…",
    nbsp = "␣",
}
vim.opt.list = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.termguicolors = true

vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.opt.winborder = "rounded"
