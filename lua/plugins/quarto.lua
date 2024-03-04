return {
  {
    "stevearc/dressing.nvim", enabled = false
  }, {
  "quarto-dev/quarto-nvim",
  opts = {
    lspFeatures = {
      languages = { "r", "python", "julia", "bash", "html", "lua" }, -- Modify if we need more languages
    },
  },
  ft = "quarto",

  -- Keymaps
  keys = {
    { "<localleader>qa", ":QuartoActivate<cr>" },
    { "<localleader>qp", ":lua require'quarto'.quartoPreview()<cr>" },
    { "<localleader>qq", ":lua require'quarto'.quartoClosePreview()<cr>" },
    { "<localleader>qh", ":QuartoHelp " },
    { "<localleader>qe", ":lua require'otter'.export()<cr>" },
    { "<localleader>qf", ":lua require'otter'.export(true)<cr>" },
    { "<localleader>qb", ":QuartoSendAbove<cr>" },
    { "<localleader>qs", ":QuartoSendAll<cr>" },
    { "<leader><cr>",    ":SlimeSend<cr>" },
    { "<c-cr>",          ":SlimeSend<cr>" },
    { "<c-cr>",          "<esc>:SlimeSend<cr>i" },
    { "<c-cr>",          "<Plug>SlimeRegionSend<cr>",                    mode = "v" },
    { "<cr>",            "<Plug>SlimeRegionSend<cr>",                    mode = "v" },
    { "<leader>ctr",     ":split term://R<cr>" },
    { "<leader>cti",     ":split term://ipython<cr>" },
    { "<leader>ctp",     ":split term://python<cr>" },
    { "<leader>ctj",     ":split term://julia<cr>" },
  },
},

  {
    "jmbuhr/otter.nvim",
    opts = {
      buffers = {
        set_filetype = true,
      },
    },
  },
  -- send code from python/r/qmd documets to a terminal or REPL
  -- like ipython, R, bash
  {
    "jpalardy/vim-slime",
    init = function()
      vim.b["quarto_is_" .. "python" .. "_chunk"] = false
      Quarto_is_in_python_chunk = function()
        require("otter.tools.functions").is_otter_language_context("python")
      end

      vim.cmd([[
      let g:slime_dispatch_ipython_pause = 100
      function SlimeOverride_EscapeText_quarto(text)
      call v:lua.Quarto_is_in_python_chunk()
      if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk
      return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
      else
      return a:text
      end
      endfunction
      ]])

      local function mark_terminal()
        vim.g.slime_last_channel = vim.b.terminal_job_id
        vim.print(vim.g.slime_last_channel)
      end

      local function set_terminal()
        vim.b.slime_config = { jobid = vim.g.slime_last_channel }
      end

      -- slime, neovvim terminal
      vim.g.slime_target = "neovim"
      vim.g.slime_python_ipython = 1

      --  Custom which-key descriptions
      require("which-key").register({
        ["<localleader>q"] = { "Quarto" },
        ["<localleader>qa"] = { "Activate" },
        ["<localleader>qp"] = { "Preview" },
        ["<localleader>qq"] = { "Close" },
        ["<localleader>qh"] = { "Help" },
        ["<localleader>qe"] = { "Export" },
        ["<localleader>qf"] = { "Force Export" },
        ["<localleader>qb"] = { "Send Above" },
        ["<localleader>qs"] = { "Send All" },
        ["<leader>cm"] = { mark_terminal, "mark terminal" },
        ["<leader>cs"] = { set_terminal, "set terminal" },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        pyright = {},
        r_language_server = {},
        julials = {},
        marksman = {
          -- also needs:
          -- $home/.config/marksman/config.toml :
          -- [core]
          -- markdown.file_extensions = ["md", "markdown", "qmd"]
          filetypes = { "markdown", "quarto" },
          root_dir = require("lspconfig.util").root_pattern(".git", ".marksman.toml", "_quarto.yml"),
        },
      },
    },
  },
}
