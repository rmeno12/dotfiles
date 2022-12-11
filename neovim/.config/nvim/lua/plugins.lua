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
      event = 'BufReadPre',
      requires = {
        -- Automatically install LSPs to stdpath for neovim
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

        -- Useful status updates for LSP
        'j-hui/fidget.nvim',
      },
      config = function()
        require('mason').setup()
        require('config.lsp').setup()
      end,
    }

    -- autocomplete
    use {
      'L3MON4D3/LuaSnip',
      wants = 'friendly-snippets',
      config = function()
        require('config.luasnip').setup()
      end,
    }
    use {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      opt = true,
      config = function()
        require('config.cmp').setup()
      end,
      requires = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        'ray-x/cmp-treesitter',
        'hrsh7th/cmp-nvim-lsp',
        'saadparwaiz1/cmp_luasnip',
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
      },
      disable = false,
    }

    use { -- Highlight, edit, and navigate code
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require('config.treesitter').setup()
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

    -- file explorer/tree
    use {
      'nvim-neo-tree/neo-tree.nvim',
      branch = 'v2.x',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
      },
      cmd = { 'Neotree' },
      config = function ()
        require('config.neo-tree').setup()
      end
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
      config = function()
        require('config.which-key').setup()
      end,
    }
    use {
      'voldikss/vim-floaterm',
      cmd = {'FloatermNew', 'FloatermToggle'},
      config = function()
        require('config.floaterm').setup()
      end,
    }

    -- decay colorscheme
    -- use {
    --   'decaycs/decay.nvim',
    --   as = 'decay',
    --   config = function()
    --     require('config.color.decay').setup()
    --   end,
    -- }
    use {
      'marko-cerovac/material.nvim',
      config = function()
        require('config.color.material').setup()
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
