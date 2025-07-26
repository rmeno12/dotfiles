return {
    {
        "saghen/blink.cmp",
        version = "1.*",
        opts = {
            keymap = { preset = "enter" },
            fuzzy = {
                sorts = {
                    "exact",
                    -- defaults
                    "score",
                    "sort_text",
                },
            },
            completion = {
                accept = {
                    auto_brackets = { enabled = true },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = {
                        border = "rounded",
                    },
                },
                -- list = { selection = { preselect = false } },
                menu = {
                    border = "rounded",
                    winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
                },
            },
            signature = { enabled = true },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },
        opts = {
            servers = {
                cmake = {},
                clangd = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            -- Make the server aware of Neovim runtime files
                            runtime = {
                                version = "LuaJIT",
                            },
                            -- Neovim's Lua docs are labelled with "vim"
                            diagnostics = {
                                globals = { "vim" },
                            },
                            workspace = {
                                -- Make the server aware of other files in your config directory
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false, -- Avoids warnings for 3rd-party libs
                            },
                            -- Do not send telemetry data for privacy
                            telemetry = {
                                enable = false,
                            },
                        },
                    },
                },
                rust_analyzer = {
                    enabled = true,
                    settings = {
                        check = {
                            command = "clippy",
                        },
                    },
                },
            },
        },
        config = function(_, opts)
            local lspconfig = require("lspconfig")
            local capabilities = {
                workspace = {
                    fileOperations = {
                        didRename = true,
                        willRename = true,
                    },
                },
            }
            for server, config in pairs(opts.servers) do
                config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
                lspconfig[server].setup(config)
            end

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
            vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
            vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Go to implementation" })
            vim.keymap.set("n", "gY", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
            vim.keymap.set("n", "<Leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
        end,
    },
    {
        "stevearc/conform.nvim",
        lazy = true,
        cmd = "ConformInfo",
        event = { "BufWritePre" },
        keys = {
            {
                "<leader>cf",
                function()
                    require("conform").format({ async = true })
                end,
                mode = { "n", "v" },
                desc = "Format buffer",
            },
            {
                "<leader>cF",
                function()
                    require("conform").format({ formatters = { "injected" }, timeout_ms = 500 })
                end,
                mode = { "n", "v" },
                desc = "Format Injected Langs",
            },
        },
        opts = {
            formatters_by_ft = {
                cmake = { "cmake_format" },
                c = { "clang-format" },
                cpp = { "clang-format" },
                cuda = { "clang-format" },
                lua = { "stylua" },
                rust = { "rustfmt" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                -- javascript.jsx = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                -- typescript.tsx = { "prettier" },
            },
        },
    },
}
