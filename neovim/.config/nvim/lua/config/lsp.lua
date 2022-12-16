local M = {}

local servers = { 'clangd', 'rust_analyzer', 'pyright', 'sumneko_lua' }

local function on_attach(client, bufnr)
  local whichkey = require('which-key')
  local keymap = vim.keymap.set

  keymap('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation', buffer = bufnr })
  -- keymap('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation', buffer = bufnr })

  local keymap_l = {
    l = {
      name = 'LSP',
      r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
      a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
      d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line Diagnostics" },
      i = { "<cmd>LspInfo<CR>", "Lsp Info" },
    },
  }
  if client.server_capabilities.documentFormattingProvider then
    keymap_l.l.f = { "<cmd>lua vim.lsp.buf.format()<CR>", "Format Document" }
  end

  local keymap_g = {
    name = "Goto",
    d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
    D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
    s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
  }
  whichkey.register(keymap_l, { buffer = bufnr, prefix = "<leader>" })
  whichkey.register(keymap_g, { buffer = bufnr, prefix = "g" })
end

function M.setup()
  require('mason').setup()
  require('mason-lspconfig').setup {
    ensure_installed = servers,
  }

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end

  require('fidget').setup()
end

return M
