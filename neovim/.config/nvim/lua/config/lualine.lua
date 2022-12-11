local M = {}

function M.setup()
  require('lualine').setup {
    options = {
      -- theme = 'decay',
      globalstatus = true,
    },
  }
end

return M
