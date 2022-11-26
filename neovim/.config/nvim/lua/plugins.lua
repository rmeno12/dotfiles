local M = {}

function M.setup()
  local is_bootstrap = false

  -- packer configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 0,
    },
    display = {
      open_fn = function()
        return require('packer.util').float { border = 'rounded' }
      end,
    },
  }

  local function packer_init()
    local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
      is_bootstrap = true
      vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
      vim.cmd [[packadd packer.nvim]]
    end
  end

  local function plugins(use)
    use 'wbthomason/packer.nvim'

    -- startup performance boost
    use 'lewis6991/impatient.nvim'

    use { 'nvim-lua/plenary.nvim', module = 'plenary' }

    -- LSP config
    use {
      'neovim/nvim-lspconfig',
      requires = {
        -- Automatically install LSPs to stdpath for neovim
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

        -- Useful status updates for LSP
        'j-hui/fidget.nvim',
      },
    }

    -- autocomplete
    use {
      'hrsh7th/nvim-cmp',
      requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
    }

    use { -- Highlight, edit, and navigate code
      'nvim-treesitter/nvim-treesitter',
      run = function()
        pcall(require('nvim-treesitter.install').update { with_sync = true })
      end,
    }

    -- git related plugins
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use {
      'lewis6991/gitsigns.nvim',
      event = 'BufReadPre',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function() 
        require('config.gitsigns').setup()
      end,
    }

    -- misc
    use { -- statusline
      'nvim-lualine/lualine.nvim',
      event = 'BufReadPre',
      config = function()
        require('config.lualine').setup()
      end,
    }
    use { -- identation guides on blank lines
      'lukas-reineke/indent-blankline.nvim',
      event = 'BufReadPre',
      config = function()
        require('config.indent-blankline').setup()
      end,
    }
    use { -- comment actions
      'numToStr/Comment.nvim',
      opt = true,
      keys = { "gc", "gcc", "gbc" },
      config = function()
        require('config.Comment').setup()
      end,
    }
    use 'tpope/vim-sleuth' -- automatically detect tab width
    use { -- key mapping help
      'folke/which-key.nvim',
      even = 'VimEnter',
      config = function()
        require('config.which-key').setup()
      end,
    }

    if is_bootstrap then
      print "Restart required after installing plugins."
      require('packer').sync()
    end
  end

  packer_init()
  local packer = require('packer')

  pcall(require, 'impatient')

  packer.init(conf)
  packer.startup(plugins)
end

return M
