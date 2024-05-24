vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Navigate vim panes better
vim.keymap.set('n', '<S-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<S-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<S-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<S-l>', ':wincmd l<CR>')

-- Debugging 
vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>")
vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")

-- Telescope
-- See plugin file 

-- Git  
vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
vim.keymap.set("n", "<leader>gl", ":Gitsigns toggle_current_line_blame<CR>", {})
vim.keymap.set("n", "<leader>gb", ":Git blame <CR>", {})

-- LSP  
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>fa", vim.lsp.buf.code_action, {})

-- Markdown Preview  
vim.api.nvim_set_keymap("n", "<localleader>mp", ":MarkdownPreview<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<localleader>ma", ":MarkdownPreviewToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<localleader>mq", ":MarkdownPreviewStop<CR>", { noremap = true })

-- Quarto
-- See plugin file

-- Neotree  
vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
-- vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})

-- Synthax  
vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, {})

-- VimTex  
vim.keymap.set("n", "<localleader>ll", ":VimtexCompile<CR>")
vim.keymap.set("n", "<localleader>lv", ":VimtexView<CR>")

