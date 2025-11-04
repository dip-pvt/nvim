


vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end,
    {desc="Open Diagnostics in Float"}
)


vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Clear highlights on search when pressing <Esc> in normal mode




-- delete without yank
-- Delete Line (dd)
vim.keymap.set("n", "<leader>dd", "\"_dd", { desc = "Delete Line (No Yank)" })
-- Delete Operator (d)
-- This allows you to use motions like <leader>dw (delete word) or <leader>d$ (delete to EOL)
vim.keymap.set("n", "<leader>d", "\"_d", { desc = "Delete Operator (No Yank)" })
-- Delete to End of Line (D)
vim.keymap.set("n", "<leader>D", "\"_D", { desc = "Delete to EOL (No Yank)" })
-- Delete Character (x)
vim.keymap.set("n", "<leader>x", "\"_x", { desc = "Delete Character (No Yank)" })
-- Change Line (cc)
vim.keymap.set("n", "<leader>cc", "\"_cc", { desc = "Change Line (No Yank)" })
-- Change Operator (c)
-- This allows you to use motions like <leader>cw (change word) or <leader>ciw (change inner word)
vim.keymap.set("n", "<leader>c", "\"_c", { desc = "Change Operator (No Yank)" })
-- Change to End of Line (C)
vim.keymap.set("n", "<leader>C", "\"_C", { desc = "Change to EOL (No Yank)" })
-- Substitute Character (s)
vim.keymap.set("n", "<leader>s", "\"_s", { desc = "Substitute Character (No Yank)" })
-- Substitute Line (S)
vim.keymap.set("n", "<leader>S", "\"_S", { desc = "Substitute Line (No Yank)" })



-- Delete Selection (d or x)
vim.keymap.set("v", "<leader>d", "\"_d", { desc = "Delete Selection (No Yank)" })
vim.keymap.set("v", "<leader>x", "\"_d", { desc = "Delete Selection (No Yank)" })
-- Change Selection (c or s)
vim.keymap.set("v", "<leader>c", "\"_c", { desc = "Change Selection (No Yank)" })
vim.keymap.set("v", "<leader>s", "\"_c", { desc = "Change Selection (No Yank)" })
-- (Bonus) Paste Over Selection Without Yanking
-- This will delete your visual selection to the black hole,
-- then paste the contents of your clipboard over it.
vim.keymap.set("v", "<leader>p", "\"_dP", { desc = "Paste Over Selection (No Yank)" })
