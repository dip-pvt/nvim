return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false, -- false: load autometic when start nvim
    
    -- ADD THIS CONFIG FUNCTION
    config = function()
      require("neo-tree").setup({

        window = {
          -- Sets the width to 30% of the screen
          width = 30,
          
          -- Or, use an absolute value (uncomment the line below)
          -- width = 45, -- Sets the width to 45 columns
          
          -- This stops neo-tree from resizing itself
          auto_resize = false
        },
        
        -- This stops neo-tree from opening automatically when you start nvim
        -- by hijacking the default file-explorer (netrw).
        filesystem = {
          hijack_netrw_behavior = "disabled", -- or "open_default"
        },
        

      })

      -- KEYMAPS to open neo-tree

      -- This is the specific command you were using

 
      vim.keymap.set("n", "-", ":Neotree toggle source=filesystem reveal=true position=right<CR>", { 
        desc = "Neo-Tree toggle reveal file" })

    end
  }
}
-- rename: r, add: file: a, folder: name/, remove:d, show/hode hidden files: H
-- Using x (Cut) and p (Paste), Using m (Move)
