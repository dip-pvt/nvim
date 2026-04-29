return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    version = "*",
    opts = {
      snippets = { preset = "default" },
      keymap = {
        preset = "default",
        ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
        ["<C-Z>"] = { "accept", "fallback" },
        ["<Enter>"] = { "select_and_accept", "fallback" },
        -- ["<C-Z>"] = { "accept", "fallback" },
        -- ["<Tab>"] = { "select_next", "fallback" },
        -- ["<S-Tab>"] = { "select_prev", "fallback" },
        -- ["<Enter>"] = { "select_and_accept", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = { documentation = { auto_show = true } },
      signature = { enabled = true },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "lua" },
      -- fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },
}
