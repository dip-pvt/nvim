return {
	"nickjvandyke/opencode.nvim",
	version = "*", -- Latest stable release
	dependencies = {
		{
			---@module "snacks"
			"folke/snacks.nvim",
			optional = true,
			opts = {
				input = {},
				picker = {
					actions = {
						opencode_send = function(...)
							return require("opencode").snacks_picker_send(...)
						end,
					},
					win = {
						input = {
							keys = {
								["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
							},
						},
					},
				},
			},
		},
	},
	config = function()
		---@type opencode.Opts
		vim.g.opencode_opts = {
			-- Custom server configuration for Tmux
			-- This tells opencode.nvim to use tmux commands instead of Neovim's built-in terminal
			server = {
				start = function()
					-- Opens a vertical split in tmux (40% width) and runs opencode with the required --port flag
					-- It also names the pane 'OpenCode' so we can track it
					vim.fn.system('tmux split-window -h -p 30 -n "OpenCode" "opencode --port"')
				end,
				stop = function()
					-- Finds the tmux pane running opencode and kills it
					vim.fn.system(
						"tmux list-panes -F '#{pane_id} #{pane_name}' | grep OpenCode | awk '{print $1}' | xargs -I {} tmux kill-pane -t {}"
					)
				end,
				toggle = function()
					-- If the pane exists, focus it or kill it; otherwise, start it
					local pane_exists = vim.fn.system("tmux list-panes -F '#{pane_name}' | grep OpenCode")
					if pane_exists ~= "" then
						vim.fn.system(
							"tmux list-panes -F '#{pane_id} #{pane_name}' | grep OpenCode | awk '{print $1}' | xargs -I {} tmux select-pane -t {}"
						)
					else
						vim.g.opencode_opts.server.start()
					end
				end,
			},
		}

		vim.o.autoread = true -- Required to reload files when opencode edits them

		-- Core Action Keymaps
		vim.keymap.set({ "n", "x" }, "<leader>za", function()
			require("opencode").ask("@this: ", { submit = true }) -- Ask with selection context
		end, { desc = "AI: Ask opencode" })

		vim.keymap.set({ "n", "x" }, "<leader>zx", function()
			require("opencode").select() -- Open the prompt library/command menu
		end, { desc = "AI: Select action" })

		vim.keymap.set({ "n", "t" }, "<leader>zz", function()
			require("opencode").toggle() -- Uses the custom tmux toggle function defined above
		end, { desc = "AI: Toggle tmux window" })

	end,
}
