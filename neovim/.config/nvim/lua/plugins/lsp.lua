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
        config = function(_, opts)
            local lsps = { "cmake", "clangd", "lua_ls", "ruff", "basedpyright", "rust_analyzer" }
            vim.lsp.enable(lsps)

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    vim.keymap.set("n", "gd", Snacks.picker.lsp_definitions, { desc = "Go to definition" })
                    vim.keymap.set("n", "gD", Snacks.picker.lsp_declarations, { desc = "Go to declaration" })
                    vim.keymap.set(
                        "n",
                        "gr",
                        Snacks.picker.lsp_references,
                        { desc = "Go to references", nowait = true }
                    )
                    vim.keymap.set("n", "gI", Snacks.picker.lsp_implementations, { desc = "Go to implementation" })
                    vim.keymap.set("n", "gY", Snacks.picker.lsp_type_definitions, { desc = "Go to type definition" })
                    vim.keymap.set("n", "<Leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
                    vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
                    vim.keymap.set("n", "<Leader>ch", vim.lsp.buf.document_highlight, { desc = "Highlight" })

                    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

                    if client:supports_method("textDocument/foldingRange") then
                        local win = vim.api.nvim_get_current_win()
                        vim.wo[win][0].foldmethod = "expr"
                        vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
                    end
                end,
            })
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
                python = { "ruff_organize_imports", "ruff_format" },
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
