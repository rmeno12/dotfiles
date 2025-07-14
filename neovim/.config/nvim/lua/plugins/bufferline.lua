return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/snacks.nvim" },
    config = function()
        vim.opt.termguicolors = true
        require("bufferline").setup()

        vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Open file explorer" })
        vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Open file explorer" })

        local snacks = require("snacks")
        vim.keymap.set("n", "<Leader>bd", function()
            snacks.bufdelete()
        end, { desc = "Delete buffer" })
        vim.keymap.set("n", "<Leader>bo", function()
            snacks.bufdelete.other()
        end, { desc = "Delete other buffers" })
    end,
}
