local M = {}

function M.setup()
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  require('neo-tree').setup {
    close_if_last_window = true,
    popup_border_style = "rounded",
    window = {
      width = 30,
    },
    filesystem = {
      filtered_items = {
        visible = true,
      }
    },
    default_component_configs = {
      git_status = {
        symbols = {
          unstaged = "!",
        }
      },
    },
  }
end

return M
