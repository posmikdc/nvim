return {
  {
    "hrsh7th/cmp-nvim-lsp"
  },
  {
    "github/copilot.vim"
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets", -- TODO: Phase out with custom plugins. 
    },
    config = function()
      require('snippets') 
      -- Specify location of the snippets.lua config files
      -- Note that this is distinct from the snippets folder containing the snippets themselves
      -- The snippets.lua file references the snippets folder to load the snippets
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      -- require("luasnip.loaders.from_vscode").lazy_load() -- Load snippets from VSCode
      -- Note: We could also note vscode snippets for only certain languages, e.g.: Python
      -- Python example: require("luasnip.loaders.from_vscode").load({ include = { "python" } })

      cmp.setup({
        -- Snippet support
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        -- Window for completion suggestions 
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        -- Keymaps to navigate completions
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        -- Sources for completion suggestions
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}

