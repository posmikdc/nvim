return {
  {
    "hrsh7th/cmp-nvim-lsp"
  },
  {
    "github/copilot.lua"
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup({
        suggestion = { enabled = true }, -- toggles ghost text suggestions
        panel = { enabled = true },
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets", -- TODO: Phase out with custom plugins.
    },
    config = function()
      -- Specify location of the snippets.lua config files
      require('snippets')
      -- Note that this is distinct from the snippets folder containing the snippets themselves
      -- The snippets.lua file references the snippets folder to load the snippets
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    depedencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-otter",
      "f3fora/cmp-spell",
    },

    config = function()
      -- Some helpful local function calls
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local has_words_before = function() -- Check if the cursor has a word before it
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
      end

      -- Call cmp setup {{{
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
          ['<C-f>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),

          ['<C-n>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
              fallback()
            end
          end, { 'i', 's' }),
          ['<C-p>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm {
            select = true,
          },

          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        }),

        -- Sources for completion suggestions
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
          { name = "path" },
          { name = "otter" },   -- for code chunks in quarto
        }, {
          { name = "buffer" },
        }),
      })

      -- for friendly code snippets
      require("luasnip.loaders.from_vscode").lazy_load() -- Load snippets from VSCode
      -- Note: We could also note vscode snippets for only certain languages, e.g.: Python
      -- Python example: require("luasnip.loaders.from_vscode").load({ include = { "python" } })

      -- link quarto and rmarkdown to markdown type snippets
      luasnip.filetype_extend('quarto', { 'markdown' })
      luasnip.filetype_extend('rmarkdown', { 'markdown' })
    end,
  },
}
