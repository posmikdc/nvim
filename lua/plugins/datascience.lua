return {
	-- Running quarto in NeoVim  
	{
		"quarto-dev/quarto-nvim",
		ft = { "quarto" },
		dev = false,
		opts = {},
		dependencies = {
			-- for language features in code cells
			-- configured in lua/plugins/lsp.lua and
			-- added as a nvim-cmp source in lua/plugins/completion.lua
			"jmbuhr/otter.nvim",
		},
	},
	-- Open .ipynb files as quarto files
	{
		"GCBallesteros/jupytext.nvim",
		opts = {
			custom_language_formatting = {
				python = {
					extension = "qmd",
					style = "quarto",
					force_ft = "quarto",
				},
				r = {
					extension = "qmd",
					style = "quarto",
					force_ft = "quarto",
				},
			},
		},
	},
	-- slime code into your terminal
	{
		"jpalardy/vim-slime",
		init = function()
			vim.g.slime_target = "neovim"
			vim.g.slime_no_mappings = true

      -- Terminal functions
			local function mark_terminal()
				vim.g.slime_last_channel = vim.b.terminal_job_id
			end

			local function set_terminal()
				vim.b.slime_config = { jobid = vim.g.slime_last_channel }
			end

			local function open_terminal(cmd)
				vim.cmd("split")
				vim.cmd("terminal " .. cmd)
				mark_terminal()
				vim.cmd("wincmd p")
				set_terminal()
			end

			-- Add keymaps for opening terminals
			vim.keymap.set("n", "<localleader>r", function()
				open_terminal("R")
			end, { desc = "Open R terminal" })
			vim.keymap.set("n", "<localleader>p", function()
				open_terminal("python3")
			end, { desc = "Open Python terminal" })
			vim.keymap.set("n", "<localleader>j", function()
				open_terminal("~/.juliaup/bin/julia")
			end, { desc = "Open Julia terminal" })

			-- For specified filetypes, automatically open terminal
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "python", "r", "julia" },
				callback = function()
					local ft = vim.bo.filetype
					local terminals = {
						python = "python3",
						r = "R",
						julia = "~/.juliaup/bin/julia",
					}
					if terminals[ft] then
						open_terminal(terminals[ft])
					end
				end,
			})
		end,

		config = function()
			-- Config 
			vim.g.slime_input_pid = false
			vim.g.slime_suggest_default = true
			vim.g.slime_menu_config = false
			vim.g.slime_neovim_ignore_unlisted = false

      -- Keymaps
			vim.keymap.set("v", "<C-CR>", "<Plug>SlimeRegionSend", { remap = true, silent = false })
			vim.keymap.set("n", "<C-CR>", "<Plug>SlimeLineSend", { remap = true, silent = false })
		end,
	},
}
