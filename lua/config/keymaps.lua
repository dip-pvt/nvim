-- ============================================================================
-- NAVIGATION & UI
-- ============================================================================

-- Open diagnostics in a floating window (useful for seeing the full error)
vim.keymap.set("n", "gl", function()
	vim.diagnostic.open_float()
end, { desc = "Open Diagnostics in Float" })

-- Populate the Quickfix list with all workspace diagnostics
vim.keymap.set("n", "<leader>e", function()
	vim.diagnostic.setqflist()
end, { desc = "Open Workspace Diagnostics List" })

-- Close the Quickfix list window
vim.keymap.set("n", "<leader>E", "<cmd>cclose<CR>", { desc = "Close Diagnostics List" })

-- Clear search highlights by pressing Esc in Normal Mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear Search Highlights" })

-- ============================================================================
-- NORMAL MODE: DELETE/CHANGE WITHOUT YANKING
-- (All of these send text to the "Black Hole" register "_ )
-- ============================================================================

-- Delete operations
vim.keymap.set("n", "<leader>dd", '"_dd', { desc = "Delete Line (No Yank)" })
vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete Operator (No Yank)" })
vim.keymap.set("n", "<leader>D", '"_D', { desc = "Delete to EOL (No Yank)" })
vim.keymap.set("n", "<leader>x", '"_x', { desc = "Delete Character (No Yank)" })

-- Change operations
vim.keymap.set("n", "<leader>cc", '"_cc', { desc = "Change Line (No Yank)" })
vim.keymap.set("n", "<leader>c", '"_c', { desc = "Change Operator (No Yank)" })
vim.keymap.set("n", "<leader>C", '"_C', { desc = "Change to EOL (No Yank)" })

-- Substitute operations
-- Note: 's' and 'S' are useful, but keep an eye on plugin conflicts
vim.keymap.set("n", "<leader>s", '"_s', { desc = "Substitute Character (No Yank)" })
vim.keymap.set("n", "<leader>S", '"_S', { desc = "Substitute Line (No Yank)" })

-- ============================================================================
-- VISUAL MODE: DELETE/CHANGE WITHOUT YANKING
-- ============================================================================

-- Cleaned up: Removed redundant mappings (x/s) to keep config lean
vim.keymap.set("v", "<leader>d", '"_d', { desc = "Delete Selection (No Yank)" })
vim.keymap.set("v", "<leader>c", '"_c', { desc = "Change Selection (No Yank)" })

-- The "Magic Paste": Paste over selection without losing your current clipboard
-- It deletes the selection to the black hole register, then pastes.
vim.keymap.set("v", "<leader>p", '"_dP', { desc = "Paste Over Selection (No Yank)" })
