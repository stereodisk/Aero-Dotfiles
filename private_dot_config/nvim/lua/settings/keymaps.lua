local opts = { noremap = true, silent = true }
vim.g.mapleader = " "

-- @GENERIC SHORTCUTS
vim.keymap.set("n", "<leader>y", "<cmd> %y+ <CR>")
vim.keymap.set("i", "<C-a>", "<Home>")
vim.keymap.set("i", "<C-e>", "<End>")

-- @SEARCH
local builtin = require("telescope.builtin")

-- Telescope Files
vim.keymap.set("n", "<C-p>", builtin.find_files, opts)
vim.keymap.set("n", "<C-o>", builtin.oldfiles, opts)

-- Telescope Strings
vim.keymap.set("n", "<C-l>", builtin.live_grep, opts)

-- Telescope History
vim.keymap.set("n", "<C-c>", builtin.command_history, opts)
vim.keymap.set("n", "<C-s>", builtin.search_history, opts)

-- Telescope Diagnostics
vim.keymap.set("n", "<C-d>", builtin.diagnostics, opts)

-- Telescope Git
vim.keymap.set("n", "<leader>gs", builtin.git_status, opts)
vim.keymap.set("n", "<leader>gc", builtin.git_commits, opts)
vim.keymap.set("n", "<leader>gb", builtin.git_branches, opts)

-- Oil
vim.keymap.set("n", "<C-{>", "<cmd> Oil<CR>", opts)
vim.keymap.set("n", "-", "<cmd> Oil --float<CR>", opts)

-- @LSP
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "<leader>re", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
vim.keymap.set("n", "<leader>gf", function() -- format
	require("conform").format({ lsp_format = "fallback" })
end, opts)

-- LSP Manager
vim.keymap.set("n", "<C-k>", "<cmd>Mason<CR>", opts)

-- @DIAGNOSTICS
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
vim.keymap.set("n", "<leader>h", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, opts)

-- @TERMINAL
-- vim Builtin Terminal
vim.keymap.set("n", "<leader>t", function()
	vim.cmd.vsplit()
	vim.api.nvim_win_set_width(0, 40)
	vim.cmd.term()
	vim.cmd.startinsert()
end, opts)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts) -- vim modes in Terminal

-- @VSPLIT
vim.keymap.set("n", "<leader>vs", "<cmd>vsplit<CR>", opts)

-- @UNDOTREE
vim.keymap.set("n", "<leader>u", require("undotree").open)
