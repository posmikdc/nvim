return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- Customize your formatters and linters
				null_ls.builtins.formatting.stylua, -- lua
				null_ls.builtins.formatting.prettier, -- general
				null_ls.builtins.formatting.black, -- python
				null_ls.builtins.formatting.isort, -- python
				null_ls.builtins.diagnostics.erb_lint, -- html/ruby
			},
		})
	end,
}
