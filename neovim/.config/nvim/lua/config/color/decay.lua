local M = {}

function M.setup()
  require('decay').setup {
    style = 'dark',
    nvim_tree = {
      contrast = true,
    },
  }
end

return M
