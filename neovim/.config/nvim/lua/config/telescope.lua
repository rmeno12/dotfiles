local M = {}

function M.setup()
  require('telescope').setup {
    defaults = {
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
    },
  }

  -- enable using native fzf if available
  pcall(require('telescope').load_extension, 'fzf')
end

return M

