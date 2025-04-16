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
            "rust", 
            "c", 
            "lua", 
            "vim", 
            "vimdoc", 
            "query",
            "json",
            "csv",
            "java",  
            "javascript", 
            "html" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
          require'nvim-treesitter.configs'.setup {
            incremental_selection = {
              enable = true,
              keymaps = {
                init_selection = "<Enter>", -- set to `false` to disable one of the mappings
                node_incremental = "<Enter>",
                scope_incremental = false,
                node_decremental = "<Backspace>",  --need to think about (helping in delete)
              },
            },
          }
        })
    end
 }