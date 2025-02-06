-- Globals
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.relativenumber = true

-- Heavy-use keybindings
vim.keymap.set("n", "<C-f>", function()
	local word = vim.fn.input("Search for: ")
	if word ~= "" then
		vim.fn.setreg("/", word)
		vim.cmd("normal! n")
	end
end, { desc = "Search in file" })

vim.keymap.set("n", "<C-r>", function()
	local find = vim.fn.input("Find and Replace: ")
	if find == "" then
		return
	end
	local replace = vim.fn.input("Replace with: ")
	if replace == "" then
		return
	end

	vim.cmd(string.format("%%s/%s/%s/gc", find, replace))
end, { desc = "Find and replace" })

-- Splash level descriptions
vim.keymap.set("n", "<leader>d", "", { desc = "Debug/Diagnostics " })
vim.keymap.set("n", "<leader>f", "", { desc = "Formatting " })
vim.keymap.set("n", "<leader>g", "", { desc = "Git " })
vim.keymap.set("n", "<leader>t", "", { desc = "Telescope " })
vim.keymap.set("n", "<localleader>l", "", { desc = "LaTeX Files " })
vim.keymap.set("n", "<localleader>m", "", { desc = "Markdown Files " })
vim.keymap.set("n", "<localleader>q", "", { desc = "Quarto Files " })

-- Navigate vim panes better
vim.keymap.set("n", "<S-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<S-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<S-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<S-l>", ":wincmd l<CR>")

-- Debugging
vim.keymap.set("n", "<leader>dt", ":DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>", { desc = "Continue" })
vim.keymap.set("n", "<leader>dx", ":DapTerminate<CR>", { desc = "Terminate" })
vim.keymap.set("n", "<leader>do", ":DapStepOver<CR>", { desc = "Step over" })

-- Telescope
-- See file plugin

-- Git
vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>gl", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Line blame" })
vim.keymap.set("n", "<leader>gb", ":Git blame <CR>", { desc = "Blame" })

-- LSP
-- vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, {desc = "Buffer definitions" })
-- vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, {desc = "Buffer references"})

-- Markdown Preview
vim.api.nvim_set_keymap("n", "<localleader>mp", ":MarkdownPreview<CR>", { noremap = true, desc = "Show preview" })
vim.api.nvim_set_keymap(
	"n",
	"<localleader>ma",
	":MarkdownPreviewToggle<CR>",
	{ noremap = true, desc = "Activate preview" }
)
vim.api.nvim_set_keymap("n", "<localleader>mq", ":MarkdownPreviewStop<CR>", { noremap = true, desc = "Quit preview" })

-- Quarto
vim.api.nvim_set_keymap("n", "<localleader>qp", ":QuartoPreview<CR>", { noremap = true, desc = "Preview Quarto" })
vim.api.nvim_set_keymap("n", "<localleader>qa", ":QuartoActivate<CR>", { noremap = true, desc = "Activate Quarto" })

-- Slime
vim.keymap.set("v", "<C-CR>", "<Plug>SlimeRegionSend", { remap = true })
vim.keymap.set("n", "<C-CR>", "<Plug>SlimeLineSend", { remap = true })

vim.keymap.set("n", "<localleader>r", function()
	open_terminal("R")
end, { desc = "Open R terminal" })
vim.keymap.set("n", "<localleader>p", function()
	open_terminal("python3")
end, { desc = "Open Python terminal" })
--vim.keymap.set("n", "<localleader>j", function()
--  open_terminal("~/.juliaup/bin/julia")
--end, { desc = "Open Julia terminal" })

-- Syntax
vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, { desc = "Format code" })
vim.keymap.set("n", "<leader>fa", vim.lsp.buf.code_action, { desc = "Code Actions" })

-- VimTex
vim.keymap.set("n", "<localleader>ll", ":VimtexCompile<CR>", { desc = "Compile LaTeX" })
vim.keymap.set("n", "<localleader>lv", ":VimtexView<CR>", { desc = "View LaTeX" })
