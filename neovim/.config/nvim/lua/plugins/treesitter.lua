return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        event = "VeryLazy",
        lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            textobjects = {
                -- move = {
                --     enable = true,
                --     goto_next_start = {
                --         ["]f"] = "@function.outer",
                --         ["]c"] = "@class.outer",
                --         ["]a"] = "@parameter.inner",
                --     },
                --     goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
                --     goto_previous_start = {
                --         ["[f"] = "@function.outer",
                --         ["[c"] = "@class.outer",
                --         ["[a"] = "@parameter.inner",
                --     },
                --     goto_previous_end = {
                --         ["[F"] = "@function.outer",
                --         ["[C"] = "@class.outer",
                --         ["[A"] = "@parameter.inner",
                --     },
                -- },
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "master",
        event = "VeryLazy",
        enabled = true,
    },
}
