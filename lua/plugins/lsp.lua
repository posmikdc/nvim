return {
  {
    -- for lsp features in code cells / embedded code
    'jmbuhr/otter.nvim',
    dev = false,
    dependencies = {
      {
        'neovim/nvim-lspconfig',
        'nvim-treesitter/nvim-treesitter',
      },
    },
    opts = {
      verbose = {
        no_code_found = false,
      },
      buffers = {
        -- if set to true, the filetype of the otterbuffers will be set.
        -- otherwise only the autocommand of lspconfig that attaches
        -- the language server will be executed without setting the filetype
        set_filetype = true,
      },
    },
    config = function()
      -- Activate Otter for Quarto files
      vim.api.nvim_create_autocmd({ "BufEnter" }, {
        pattern = { "*.qmd", "*.rmd", "*.md" },
        callback = function()
          require('otter').activate()
        end,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")
      
      lspconfig.tsserver.setup({
        capabilities = capabilities
      })
      
      lspconfig.html.setup({
        capabilities = capabilities
      })
      
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      
      lspconfig.r_language_server.setup({
        capabilities = capabilities
      })
      
      lspconfig.pyright.setup({
        capabilities = capabilities
      })

      -- Custom which-key descriptions
      local wk = require("which-key")
      wk.register({
        ["<leader>f"] = { "Format Code" },
        ["<leader>fa"] = { "Code Actions" },
      })
    end,
  },
}
