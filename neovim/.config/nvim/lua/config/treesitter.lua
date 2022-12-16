local M = {}

function M.setup()
  require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'cpp', 'python', 'cmake', 'make', 'lua', 'dockerfile', 'bash', 'rust' },

    sync_install = false,

    highlight = {
      enable = true,
    },
  }
end

return M
