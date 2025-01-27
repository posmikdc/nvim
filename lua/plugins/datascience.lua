return {
	-- Running quarto in NeoVim
	{
		"quarto-dev/quarto-nvim",
		ft = { "quarto" },
		dev = false,
		opts = {},
		dependencies = {
			"jmbuhr/otter.nvim",
		},
	},
	-- slime code into your terminal
	{
		"jpalardy/vim-slime",
		init = function()
			vim.g.slime_target = "neovim"
			vim.g.slime_default_config = { jobid = "" }
			vim.g.slime_dont_ask_default = true
			-- Add basic terminal function
			open_terminal = function(cmd)
				-- Extract just the command name without path
				local cmd_name = cmd:match("[^/]*$"):gsub("3$", "") -- Remove '3' from 'python3'
				vim.cmd("split")
				vim.cmd("terminal " .. cmd)
				-- Get the terminal job ID
				vim.defer_fn(function()
					local buf = vim.api.nvim_get_current_buf()
					local job_id = vim.b[buf].terminal_job_id
					if job_id then
						-- Set both buffer-local and default config
						vim.b.slime_config = { jobid = job_id }
						vim.g.slime_default_config = { jobid = job_id }
						-- Print confirmation message with terminal ID
						vim.api.nvim_echo(
							{
								{
									string.format("Opening %s terminal. Terminal ID is %s", cmd_name:upper(), job_id),
									"Normal",
								},
							},
							true,
							{}
						)
						vim.cmd("wincmd p") -- Go back to previous window
					end
				end, 100)
			end
			-- Add keymaps for all supported terminals
			vim.keymap.set("n", "<localleader>r", function()
				open_terminal("R")
			end, { desc = "Open R terminal" })
			vim.keymap.set("n", "<localleader>p", function()
				open_terminal("python3")
			end, { desc = "Open Python terminal" })
			vim.keymap.set("n", "<localleader>j", function()
				open_terminal("~/.juliaup/bin/julia")
			end, { desc = "Open Julia terminal" })
		end,
		config = function()
			vim.keymap.set("v", "<C-CR>", "<Plug>SlimeRegionSend", { remap = true })
			vim.keymap.set("n", "<C-CR>", "<Plug>SlimeLineSend", { remap = true })
		end,
	},
}
