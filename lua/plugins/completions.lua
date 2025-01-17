return {
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
      require('nvim-autopairs').remove_rule '`'
    end,
  },

	{
		"hrsh7th/cmp-nvim-lsp",
	},

	-- {
	--  "github/copilot.vim"
	-- },

	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets", -- Friendly snippets are a nice collection of common snippets
		},
		config = function()
			-- Specify location of the snippets.lua config files
			require("snippets") -- Configuration for LuaSnip
			local ls = require("luasnip")

			-- LuaSnip Keymaps
			vim.keymap.set({ "i", "s" }, "<c-k>", function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<c-j>", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<c-l>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<c-h>", function()
				if ls.choice_active() then
					ls.change_choice(-1)
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<c-y>", function()
				if ls.choice_active() then
					ls.select_choice()
				end
			end, { silent = true })
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		-- event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-emoji",
			"saadparwaiz1/cmp_luasnip",
			"f3fora/cmp-spell",
			"ray-x/cmp-treesitter",
			"kdheepak/cmp-latex-symbols",
			"jmbuhr/cmp-pandoc-references",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind-nvim",
			"jmbuhr/otter.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				mapping = {
					["<C-f>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol",
						menu = {
              otter = '[🦦]',
							nvim_lsp = "[LSP]",
							nvim_lsp_signature_help = "[sig]",
							luasnip = "[snip]",
							buffer = "[buf]",
							path = "[path]",
							spell = "[spell]",
							pandoc_references = "[ref]",
							treesitter = "[TS]",
							calc = "[calc]",
							latex_symbols = "[tex]",
							emoji = "[emoji]",
						},
					}),
				},
				sources = {
          { name = "otter",
            priority = 99
          }, -- For code chunks in quarto
					{ name = "path" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lsp" },
					{ name = "luasnip", keyword_length = 3, max_item_count = 3 },
					{ name = "pandoc_references" },
					{ name = "buffer", keyword_length = 5, max_item_count = 3 },
					{ name = "spell" },
					{ name = "treesitter", keyword_length = 5, max_item_count = 3 },
					{ name = "calc" },
					{ name = "latex_symbols" },
					{ name = "emoji" },
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})

			-- for friendly snippets
			require("luasnip.loaders.from_vscode").lazy_load()
			-- for custom snippets
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
			-- link quarto and rmarkdown to markdown snippets
			luasnip.filetype_extend("quarto", { "markdown" })
			luasnip.filetype_extend("rmarkdown", { "markdown" })
		end,
	},
}


