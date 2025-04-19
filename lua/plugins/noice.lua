-- -- enhance the user experience by providing a better command line interface and notifications.

-- return {
-- 	"folke/noice.nvim",
-- 	event = "VeryLazy",
-- 	opts = {
-- 		-- add any options here
-- 	},
-- 	dependencies = {
-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
-- 		"MunifTanjim/nui.nvim",
-- 		-- OPTIONAL:
-- 		--   `nvim-notify` is only needed, if you want to use the notification view.
-- 		--   If not available, we use `mini` as the fallback
-- 		"rcarriga/nvim-notify",
-- 	},
-- }

return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
	  -- UI component library required by Noice
	  "MunifTanjim/nui.nvim",
	  -- Optional notification backend (fallback to `mini` if absent)
	  "rcarriga/nvim-notify",
	},
	-- You can add your Noice-specific options here
	opts = {
	  -- e.g. lsp overrides, message views, popupmenu settings, etc.
	},
	-- Setup Noice and hook in macro-record notifications
	config = function(_, opts)
	  -- 1) Initialize Noice
	  require("noice").setup(opts)
  
	  -- 2) Common notification options for macro alerts
	  local notify_opts = {
		title   = "Macro",
		timeout = 2000,
		merge   = false,
	  }
  
	  -- 3) Create an augroup to manage our autocmds
	  vim.api.nvim_create_augroup("MacroNotify", { clear = true })
  
	  -- 4) Notify on RecordingEnter (e.g. `qa`)
	  vim.api.nvim_create_autocmd("RecordingEnter", {
		group = "MacroNotify",
		callback = function()
		  local reg = vim.fn.reg_recording()
		  if reg ~= "" then
			-- Use vim.notify; Noice will route it through its notify view
			vim.notify("Recording @" .. reg, vim.log.levels.INFO, notify_opts)
		  end
		end,
	  })
  
	  -- 5) Notify on RecordingLeave (when you stop recording)
	  vim.api.nvim_create_autocmd("RecordingLeave", {
		group = "MacroNotify",
		callback = function()
		  vim.notify("Recording stopped", vim.log.levels.INFO, notify_opts)
		end,
	  })
	end,
  }
  
