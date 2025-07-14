local k = vim.keymap

k.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New buffer" })

local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end
k.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
k.set("n", "]d", diagnostic_goto(true), { desc = "Next diagnostic" })
k.set("n", "[d", diagnostic_goto(false), { desc = "Prev diagnostic" })
k.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next error" })
k.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev error" })
k.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next warning" })
k.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev warning" })

k.set("n", "<leader>-", "<C-w>s", {desc = "Split below"})
k.set("n", "<leader>|", "<C-w>v", {desc = "Split right"})
