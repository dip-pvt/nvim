return {
  "neovim/nvim-lspconfig",

  dependencies = {
    { "williamboman/mason.nvim", opts = {} },
  },

  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),

      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, {
            buffer = event.buf,
            desc = "LSP: " .. desc,
          })
        end

        -- Navigation
        map("gd", require("fzf-lua").lsp_definitions, "Goto Definition")
        map("gr", require("fzf-lua").lsp_references, "References")
        map("gI", require("fzf-lua").lsp_implementations, "Implementation")
        map("<leader>D", require("fzf-lua").lsp_typedefs, "Type Definition")
        map("<leader>ds", require("fzf-lua").lsp_document_symbols, "Document Symbols")
        map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "Workspace Symbols")

        -- Actions
        map("<leader>cr", vim.lsp.buf.rename, "Rename")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
        map("gD", vim.lsp.buf.declaration, "Declaration")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
          return
        end

        -- Document Highlight
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = group,
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            group = group,
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
            callback = function(ev)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({
                group = "lsp-highlight",
                buffer = ev.buf,
              })
            end,
          })
        end

        -- Inlay Hints
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(
              not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
            )
          end, "Toggle Inlay Hints")
        end
      end,
    })

    vim.diagnostic.config({
      severity_sort = true,

      float = {
        border = "rounded",
        source = "if_many",
      },

      underline = {
        severity = vim.diagnostic.severity.ERROR,
      },

      virtual_text = {
        source = "if_many",
        spacing = 2,
      },

      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN] = "󰀪 ",
          [vim.diagnostic.severity.INFO] = "󰋽 ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
      },
    })
    local capabilities = require("blink.cmp").get_lsp_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )

    vim.lsp.config("bashls", {
      capabilities = capabilities,
    })

    vim.lsp.config("pyright", {
      capabilities = capabilities,
      settings = {
        pyright = {
          disableOrganizeImports = true,
        },
        python = {
          analysis = {
            typeCheckingMode = "off",
          },
        },
      },
    })

    vim.lsp.config("ruff", {
      capabilities = capabilities,

      init_options = {
        settings = {
          organizeImports = true,
        },
      },

      on_attach = function(client)
        client.server_capabilities.hoverProvider = false
      end,
    })

    vim.lsp.config("gopls", {
        capabilities = capabilities,
      })

      vim.lsp.enable({
        "bashls",
        "pyright",
        "ruff",
        "gopls",
      })
    end,
  }
