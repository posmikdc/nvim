return {
  -- Running quarto in NeoVim
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto" },
    dev = false,
    opts = {},
    dependencies = {
      "jmbuhr/otter.nvim",
    },
  },
  -- slime code into your terminal
  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_target = "neovim"
      vim.g.slime_default_config = { jobid = "" }
      vim.g.slime_dont_ask_default = true -- Add this line

      -- Add basic terminal function
      _G.open_terminal = function(cmd)
        vim.cmd("split")
        vim.cmd("terminal " .. cmd)
        -- Get the terminal job ID
        vim.defer_fn(function()
          local buf = vim.api.nvim_get_current_buf()
          local job_id = vim.b[buf].terminal_job_id
          if job_id then
            -- Set both buffer-local and default config
            vim.b.slime_config = { jobid = job_id }
            vim.g.slime_default_config = { jobid = job_id }
            vim.cmd("wincmd p") -- Go back to previous window
          end
        end, 100)
      end

      -- One keymap to test
      vim.keymap.set("n", "<localleader>r", function()
        open_terminal("R")
      end, { desc = "Open R terminal" })
    end,
    config = function()
      vim.keymap.set("v", "<C-CR>", "<Plug>SlimeRegionSend", { remap = true })
      vim.keymap.set("n", "<C-CR>", "<Plug>SlimeLineSend", { remap = true })
    end,
  },
}
