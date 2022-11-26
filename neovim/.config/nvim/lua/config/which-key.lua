local M = {}

function M.setup()
  local whichkey = require('which-key')

  local conf = {
    window = {
      border = 'single',
      position = 'bottom',
    },
  }

  local opts = {
    mode = 'n',
    prefix = '<leader>',
    buffer = nil,
    silen = true,
    noremap = true,
    nowait = false,
  }

  local mappings = {
    ['w'] = { '<cmd>update!<CR>', 'Save' },
    ['q'] = { '<cmd>q<CR>', 'Quit' },

    z = {
      name = 'Packer',
      c = { '<cmd>PackerCompile<cr>', 'Compile' },
      i = { '<cmd>PackerInstall<cr>', 'Install' },
      s = { '<cmd>PackerSync<cr>', 'Sync' },
      S = { '<cmd>PackerStatus<cr>', 'Status' },
      u = { '<cmd>PackerUpdate<cr>', 'Update' },
    },
  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
end

return M

