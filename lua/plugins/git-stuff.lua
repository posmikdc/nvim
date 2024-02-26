return {
  {
    "tpope/vim-fugitive"
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()

      -- Keymaps
      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
      vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})

      -- Custom which-key descriptions
      local wk = require("which-key")
      wk.register({
        ["<leader>g"] = { "Git" },
        ["<leader>gp"] = { "Preview Hunk" },
        ["<leader>gt"] = { "Blame Current" },
      })
    end
  }
}
