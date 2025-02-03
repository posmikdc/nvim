return {
  {
    "jmbuhr/otter.nvim",
    dev = false,
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
    },
    config = function()
      -- Configure Otter
      local otter = require("otter")
      otter.setup({
        lsp = {
          diagnostic_update_events = { "BufWritePost" },
          root_dir = function(_, bufnr)
            return vim.fs.root(bufnr or 0, {
              ".git",
              "_quarto.yml",
              "package.json",
            }) or vim.fn.getcwd(0)
          end,
        },
        buffers = {
          set_filetype = false,
          write_to_disk = false,
        },
        strip_wrapping_quote_characters = { "'", '"', "`" },
        handle_leading_whitespace = true,
        extensions = {},
        debug = false,
        verbose = {
          no_code_found = false,
        },
      })

      -- Create an autocmd group for Otter
      local otter_group = vim.api.nvim_create_augroup("OtterActivation", { clear = true })

      -- Create autocmd for .qmd files
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
        group = otter_group,
        pattern = "*.qmd",
        callback = function()
          -- Activate Otter with default settings for all languages
          otter.activate(nil, true, true, nil)
          print("Otter activated for Quarto document")
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
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.html.setup({
        capabilities = capabilities,
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.r_language_server.setup({
        capabilities = capabilities,
        settings = {
          r = {
            lsp = {
              rich_documentation = false,
            },
          },
        },
      })
      lspconfig.pyright.setup({
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
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
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.html.setup({
        capabilities = capabilities,
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.r_language_server.setup({
        capabilities = capabilities,
        settings = {
          r = {
            lsp = {
              rich_documentation = false,
            },
          },
        },
      })
      lspconfig.pyright.setup({
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      })
      lspconfig.julials.setup({
        capabilities = capabilities,
      })
    end,
  },
}
