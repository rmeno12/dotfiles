return {
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
}
