
return {
  "echasnovski/mini.indentscope",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    symbol = "|",
    -- symbol = "│",
    options = {
      border = "both",
    },
    draw = {
      delay = 0, -- Draw instantly
      -- Using an empty function disables the animation engine entirely
      animation = function(s, n) return 0 end, 
    },
  },
}
