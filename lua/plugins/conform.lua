return {
    "stevearc/conform.nvim",
    event = "BufWritePre",

    opts = {
        formatters_by_ft = {
            python = { "ruff_format" },
            lua = { "stylua" },
            go = { "gofmt" },
            sh = { "shfmt" },
            bash = { "shfmt" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
        },

        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
        },

        notify_on_error = true,
        notify_no_formatters = false,
    },

    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({
                    async = true,
                    lsp_format = "fallback",
                })
            end,
            mode = { "n", "v" },
            desc = "Format Buffer",
        },
    },
}
