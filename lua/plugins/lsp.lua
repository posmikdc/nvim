return {
  
  -- Code chunk LSP support for .qmd
	{
		"jmbuhr/otter.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("otter").setup({
				lsp = {
					diagnostic_update_events = { "BufWritePost" },
					rootdir = function(_, bufnr)
						return vim.fs.root(bufnr or 0, {
							".git",
							"_quarto.yml",
							"package.json",
						}) or vim.fn.getcwd(0)
					end,
				},
				buffers = {
					set_filetype = true,
					write_to_disk = false,
				},
			})
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
				group = vim.api.nvim_create_augroup("OtterActivation", { clear = true }),
				pattern = "*.qmd",
				callback = function()
					require("otter").activate()
				end,
			})
		end,
	},

  -- Mason LSP Installer 
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},

  -- Mason LSP Config 
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},

  -- My LSP Configurations
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local servers = {
				ts_ls = {},
				html = {},
				lua_ls = {},
				r_language_server = {
					capabilities = capabilities,
					filetypes = { "r", "rmd" },
				},
				pyright = {
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
							},
						},
					},
				},
				julials = {},
			}
			for server, config in pairs(servers) do
				config.capabilities = capabilities
				lspconfig[server].setup(config)
			end

			-- Add keymapping to force LSP initialization
			vim.keymap.set("n", "<localleader>o", function()
				-- Get active LSP clients
				local active_clients = vim.lsp.get_active_clients()

				-- Start all configured servers if they're not already running
				for server_name, _ in pairs(servers) do
					local found = false
					for _, client in ipairs(active_clients) do
						if client.name == server_name then
							found = true
							break
						end
					end

					if not found then
						-- Start the server using lspconfig
						lspconfig[server_name].setup({})
					end
				end

				-- Force Otter activation if it's a qmd file
				local ft = vim.bo.filetype
				if ft == "quarto" or ft == "qmd" then
					require("otter").activate()
				end

				-- Show LSP info
				vim.cmd("LspInfo")
			end, { desc = "Toggle Otter" })
		end,
	},
}
