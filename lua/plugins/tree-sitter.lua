-- better syntax highlighting and indentation
return{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {
            "python",
            "bash", 
            "lua", 
            "vim", 
            "vimdoc", 
            "go",
            "json",
            "csv", 
            "javascript", 
            "html" },
          auto_install = true,  -- install perser when open new type of file
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true }, -- indentation, off if make problem
          require'nvim-treesitter.configs'.setup {
            incremental_selection = {
              enable = true,
              keymaps = {
                init_selection = "<Enter>", -- set to `false` to disable one of the mappings
                node_incremental = "<Enter>", -- select txts
                scope_incremental = false,
                node_decremental = "<Backspace>",  --need to think about (helping in delete)
              },
            },
          }
        })
    end
 }
