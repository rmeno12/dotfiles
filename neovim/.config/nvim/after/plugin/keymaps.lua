local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

-- move around windows
keymap('n', '<C-h>', '<C-w>h', default_opts)
keymap('n', '<C-j>', '<C-w>j', default_opts)
keymap('n', '<C-k>', '<C-w>k', default_opts)
keymap('n', '<C-l>', '<C-w>l', default_opts)

-- move around tabs
keymap('n', 'H', ':tabprev<CR>', default_opts)
keymap('n', 'L', ':tabnext<CR>', default_opts)

-- open terminal
keymap('n', '<C-t>', ':FloatermToggle<CR>', default_opts)
keymap('t', '<C-t>', '<C-\\><C-n>:FloatermToggle<CR>', default_opts)

-- commenting
keymap('n', '<C-/>', 'gcc', { noremap = false, silent = true })
keymap('n', '<C-_>', 'gcc', { noremap = false, silent = true })
keymap('v', '<C-/>', 'gc', { noremap = false, silent = true })
keymap('v', '<C-_>', 'gc', { noremap = false, silent = true })
