local M = {}

function M.setup()
  require('material').setup {
    constrast = {
      sidebars = true,
      floating_windows = true,
    },
    plugins = {
      "gitsigns",
      "indent-blankline",
      "nvim-cmp",
      "nvim-web-devicons",
      "which-key",
    },
    disable = {
      background = true,
    },
    high_visibility = {
      darker = true,
    },
    lualine_style = 'stealth',
  }

  vim.g.material_style = "darker"
  vim.cmd('colorscheme material')
end

return M
