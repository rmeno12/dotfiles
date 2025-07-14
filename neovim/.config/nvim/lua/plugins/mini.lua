return {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
        local extra = require("mini.extra")
        -- text editing
        local ai = require("mini.ai")
        ai.setup({
            n_lines = 500,
            custom_textobjects = {
                o = ai.gen_spec.treesitter({ -- code block
                    a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                    i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                }),
                f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
                c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
                t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
                d = { "%f[%d]%d+" }, -- digits
                e = { -- Word with case
                    { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
                    "^().*()$",
                },
                g = extra.gen_ai_spec.buffer(), -- buffer
                u = ai.gen_spec.function_call(), -- u for "Usage"
                U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
            },
        })
        require("mini.comment").setup()
        require("mini.surround").setup()

        -- general workflow
        require("mini.basics").setup({ mappings = { windows = true } })

        require("mini.bracketed").setup()

        local minifiles = require("mini.files")
        minifiles.setup()
        vim.keymap.set("n", "<Leader>e", MiniFiles.open, { desc = "Open file explorer" })

        require("mini.hipatterns").setup({
            highlighters = {
                fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
                hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
                todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
                note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
            },
        })
    end,
}
