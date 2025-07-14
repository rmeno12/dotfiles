return {
    "catppuccin/nvim",
    name = "catppuccin",
    flavor = "mocha",
    priority = 1000,
    opts = {
        color_overrides = {
            mocha = {
                base = "#000000",
                mantle = "#000000",
                crust = "#000000",
            },
        },
        integrations = {
            blink_cmp = {
                style = "bordered",
            },
            gitsigns = true,
            mini = true,
            native_lsp = {
                enabled = true,
                underlines = {
                    errors = { "undercurl" },
                    hints = { "undercurl" },
                    warnings = { "undercurl" },
                    information = { "undercurl" },
                },
            },
            semantic_tokens = true,
            snacks = {
                enabled = true,
            },
            treesitter = true,
        },
    },
    config = function(_, opts)
        require("catppuccin").setup(opts)
        vim.cmd.colorscheme("catppuccin")
    end,
    specs = {
        {
            "akinsho/bufferline.nvim",
            optional = true,
            opts = function(_, opts)
                if (vim.g.colors_name or ""):find("catppuccin") then
                    opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
                end
            end,
        },
    },
}
