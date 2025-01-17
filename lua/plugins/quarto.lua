return {
	{
		"quarto-dev/quarto-nvim",
		ft = { "quarto" },
		opts = {
			lspFeatures = {
				enabled = true,
				languages = { "r", "python", "julia" },
				diagnostics = {
					enabled = true,
					triggers = { "BufWrite" },
				},
				completion = {
					enabled = true,
				},
			},
		},
	},
	{
		"jmbuhr/otter.nvim",
		lazy = false,
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("otter").setup({
				buffers = {
					set_filetype = true,
				},
				tools = {
					language_servers = {
						r = { "r_language_server" },
						python = { "pyright" },
						julia = { "julia-lsp" },
					},
				},
			})

			-- Create the autocommand after setup
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "quarto", "markdown" },
				callback = function()
					vim.schedule(function()
						require("otter").activate()
					end)
				end,
			})
		end,
	},
}
