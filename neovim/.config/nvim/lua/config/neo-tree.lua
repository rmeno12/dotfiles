local M = {}

function M.setup()
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  require('neo-tree').setup {
    window = {
      width = 30,
    },
    filesystems = {
      filtered_items = {
        visible = true,
      }
    },
  }
end

return M
