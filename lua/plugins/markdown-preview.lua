return {
  {
    "iamcco/markdown-preview.nvim",
    config = function()
      vim.fn["mkdp#util#install"]()

      -- Keymaps
      vim.api.nvim_set_keymap("n", "<localleader>mp", ":MarkdownPreview<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<localleader>ma", ":MarkdownPreviewToggle<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<localleader>mq", ":MarkdownPreviewStop<CR>", { noremap = true })
      
      -- Custom which-key descriptions
      local wk = require("which-key")
      wk.register({
        ["<localleader>m"] = { "Markdown" },
        ["<localleader>mp"] = { "Preview" },
        ["<localleader>ma"] = { "Toggle" },
        ["<localleader>mq"] = { "Stop" },
      })
    end,
    ft = { "markdown" },
    event = "BufRead",
  },
}
