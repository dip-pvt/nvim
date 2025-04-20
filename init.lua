require("config.lazy")

-- my addons
-- 1. autosave after leave insert mode
-- vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
--     pattern = "*",
--     callback = function()
--       if vim.bo.modified then
--         vim.cmd("silent! write")
--       end
--     end,
--   })
  



-- auto save after some times

-- local save_timer = nil

-- vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
--   pattern = "*",
--   callback = function()
--     if save_timer then
--       save_timer:stop()
--       save_timer:close()
--     end

--     save_timer = vim.loop.new_timer()
--     save_timer:start(
--       100,  -- 100 milliseconds delay
--       0,
--       vim.schedule_wrap(function()
--         if vim.bo.modified then
--           vim.cmd('silent! write')
--         end
--       end)
--     )
--   end,
-- })
