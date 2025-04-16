-- vim inbuilt keymaps
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<C-q>", "<cmd>q<CR>") -- quit the current buffer
vim.keymap.set("n", "<C-X>", "<cmd>q!<CR>") -- force quit the current buffer (capital for "Shift")
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>") -- save the current buffer
vim.keymap.set("n", "<C-x>", "<cmd>wq<CR>") -- save the current buffer

-- oil.lua
vim.keymap.set("n", "-", "<cmd>Oil --float<CR>") -- Open Oil in a floating window

vim.keymap.set(
	"n",
	"gl",
	function()
		vim.diagnostic.open_float()
	end, -- Open diagnostics in a floating window
	{ desc = "Open Diagnostics in Float" }
)

-- conform.lua
vim.keymap.set("n", "<leader>cf", function() -- Format current file
	require("conform").format({
		lsp_format = "fallback",
	})
end, { desc = "Format current file" })

-- noice.lua
vim.keymap.set("n", "<Esc>", "<cmd>NoiceDismiss<CR>")
vim.keymap.set("n", "<leader>h", "<cmd>NoiceHistory<CR>")

-- some shortcuts in plugin/fzf.lua file
-- some shortcuts in plugin/lsp.lua file
