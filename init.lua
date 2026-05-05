-- ============================================================================
-- CLIPBOARD CONFIGURATION (UNCHANGED)
-- ============================================================================
vim.g.clipboard = {
	name = "xclip",
	copy = {
		["+"] = "xclip -selection clipboard -in",
		["*"] = "xclip -selection primary -in",
	},
	paste = {
		["+"] = "xclip -selection clipboard -out -silent",
		["*"] = "xclip -selection primary -out -silent",
	},
	cache_enabled = true,
}

-- ============================================================================
-- GENERAL SETTINGS
-- ============================================================================

-- UI & Layout
vim.opt.splitright = true -- New vertical splits open on the right
vim.opt.splitbelow = true -- New horizontal splits open at the bottom
vim.cmd.colorscheme("onedark") -- Set the colorscheme

-- Line Numbering
vim.opt.number = true -- Always show the absolute number of the current line
vim.opt.relativenumber = true -- Start with relative numbers (Normal mode)

-- Cursor & Viewing
vim.opt.cursorline = true -- Highlight current line
vim.opt.wrap = false -- Disable line wrapping
vim.opt.scrolloff = 10 -- Keep 10 lines of context above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns of context left/right

-- Indentation
vim.opt.tabstop = 4 -- Number of spaces for a tab
vim.opt.shiftwidth = 4 -- Number of spaces for auto-indent
vim.opt.softtabstop = 4 -- Number of spaces a tab counts for
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.smartindent = true -- Enable smart auto-indenting
vim.opt.autoindent = true -- Copy indent from current line

-- Search
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Case sensitive if capital letters used
vim.opt.incsearch = true -- Show matches as you type

-- Visual & Performance
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.signcolumn = "yes" -- Always show the sign column
vim.opt.showmatch = true -- Highlight matching brackets
vim.opt.matchtime = 2 -- Time to show matching bracket
vim.opt.cmdheight = 1 -- Command line height
vim.opt.completeopt = "menuone,noinsert,noselect" -- Completion options
vim.opt.showmode = false -- Hide the mode
vim.opt.pumheight = 10 -- Popup menu height
vim.opt.pumblend = 10 -- Popup menu transparency
vim.opt.winblend = 0 -- Floating window transparency
vim.opt.synmaxcol = 300 -- Limit syntax highlighting for performance

-- File & History
vim.opt.swapfile = false -- Disable swap files
vim.opt.undofile = true -- Enable persistent undo
vim.opt.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory
vim.opt.updatetime = 300 -- Faster completion and UI response
vim.opt.timeoutlen = 500 -- Key sequence timeout
vim.opt.ttimeoutlen = 50 -- Key code timeout (fixed from 0 for stability)
vim.opt.autoread = true -- Auto-reload files changed outside Neovim

-- Behavior
vim.opt.hidden = true -- Allow hidden buffers
vim.opt.errorbells = false -- Disable error bells
vim.opt.backspace = "indent,eol,start" -- Better backspace behavior
vim.opt.autochdir = false -- Don't auto change directory
vim.opt.iskeyword:append("-") -- Treat dash as part of word
vim.opt.selection = "exclusive" -- Selection behavior
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.clipboard:append("unnamedplus") -- Sync with system clipboard
vim.opt.modifiable = true -- Allow buffer modifications

-- Key Mappings
vim.g.mapleader = "," -- Set leader key
vim.g.maplocalleader = "," -- Set local leader key

-- Move Lines (Alt + j/k)
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- ============================================================================
-- AUTOCOMMANDS
-- ============================================================================

-- Group to prevent duplicate autocommands
-- FIXED: Moved this to the top of the autocommand block
local user_cmds = vim.api.nvim_create_augroup("UserCmds", { clear = true })

-- Toggle relative line numbers based on mode
-- Switch to absolute numbers when typing (InsertEnter)
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	group = user_cmds,
	callback = function()
		vim.opt.relativenumber = false
	end,
	desc = "Show absolute line numbers in Insert mode",
})

-- Switch back to relative numbers for navigation (InsertLeave)
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	group = user_cmds,
	callback = function()
		vim.opt.relativenumber = true
	end,
	desc = "Show relative line numbers in Normal mode",
})

-- Improved Auto-save
-- Automatically saves when leaving insert mode or when Neovim loses focus
vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost" }, {
	group = user_cmds,
	pattern = "*",
	callback = function()
		-- Only save if the buffer is a normal file and has been modified
		if vim.bo.buftype == "" and vim.bo.modifiable and vim.bo.modified and vim.fn.expand("%") ~= "" then
			vim.cmd("silent! write")
		end
	end,
	desc = "Auto-save on insert leave or focus loss",
})

-- Netrw settings
vim.api.nvim_create_autocmd("FileType", {
	group = user_cmds,
	pattern = "netrw",
	callback = function()
		vim.opt_local.number = true
		vim.opt_local.relativenumber = true
	end,
	desc = "Enable line numbers in file explorer",
})

-- Return to last edit position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = user_cmds,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
	desc = "Restore cursor position",
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = user_cmds,
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
	desc = "Highlight copied text",
})

-- ============================================================================
-- PLUGIN LOADING
-- ============================================================================
require("config.lazy")
