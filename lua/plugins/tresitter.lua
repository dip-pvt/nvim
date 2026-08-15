return {
    "nvim-treesitter/nvim-treesitter",

    build = ":TSUpdate",

    opts = {
        ensure_installed = {
            "lua",
            "vim",
            "vimdoc",
            "python",
            "go",
            "bash",
            "json",
            "yaml",
            "markdown",
            "markdown_inline",
            "dockerfile",
            "toml",
            "gitignore",
        },

        highlight = {
            enable = true,
        },

        indent = {
            enable = true,
        },
    },
}
