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
    ['e'] = { '<cmd>Neotree toggle<cr>', 'Explorer' },
    z = {
      name = 'Packer',
      c = { '<cmd>PackerCompile<cr>', 'Compile' },
      i = { '<cmd>PackerInstall<cr>', 'Install' },
      s = { '<cmd>PackerSync<cr>', 'Sync' },
      S = { '<cmd>PackerStatus<cr>', 'Status' },
      u = { '<cmd>PackerUpdate<cr>', 'Update' },
    },
    s = {
      name = 'Search',
      f = { "<cmd>lua require('telescope.builtin').find_files()<CR>", "Search File" },
      h = { "<cmd>lua require('telescope.builtin').help_tags()<CR>", "Search Help" },
      w = { "<cmd>lua require('telescope.builtin').grep_string()<CR>", "Search Current Word" },
      g = { "<cmd>lua require('telescope.builtin').live_grep()<CR>", "Search with Grep" },
      d = { "<cmd>lua require('telescope.builtin').diagnostics()<CR>", "Search Diagnostics" },
      s = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", "Search Symbols" },
      ['/'] = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({winblend = 10, previewer = false}))<CR>",
        'Fuzzy Search in current buffer' },
      r = { '<cmd>Telescope lsp_references<CR>', 'Search References' },
      ['?'] = { "<cmd>lua require('telescope.builtin').oldfiles()<CR>", "Search recently opened files" },
      [' '] = { "<cmd>lua require('telescope.builtin').buffers()<CR>", "Search open buffers" },
    },
  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
end

return M
