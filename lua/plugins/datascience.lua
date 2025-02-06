return {

  -- Run Quarto in NeoVim
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto" },
    opts = {},
    dependencies = { "jmbuhr/otter.nvim" },
  },

  -- Slime Code into your terminal
  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_target = "neovim"
      vim.g.slime_default_config = { jobid = "" }
      vim.g.slime_dont_ask_default = true

      -- Improved terminal function
      open_terminal = function(cmd)
        local cmd_name = cmd:gsub(".*/([^/]+)$", "%1"):gsub("3$", "")
        vim.cmd("split | terminal " .. cmd)

        vim.defer_fn(function()
          local buf = vim.api.nvim_get_current_buf()
          local job_id = vim.b[buf].terminal_job_id
          if job_id then
            vim.b.slime_config = { jobid = job_id }
            vim.g.slime_default_config = { jobid = job_id }
            vim.notify(string.format("Opening %s terminal (ID: %s)", cmd_name:upper(), job_id))
            vim.cmd("wincmd p")
          end
        end, 100)
      end
    end,
  },
}
