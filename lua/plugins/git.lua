return {
  {
    "tpope/vim-fugitive"
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()

      -- Custom which-key descriptions
      local wk = require("which-key")
      wk.register({
        ["<leader>g"] = { "Git" },
        ["<leader>gp"] = { "Preview Hunk" },
        ["<leader>gl"] = { "Toggle Line Blame" },
        ["<leader>gb"] = { "Blame History" },
      })
    end
  }
}
