return {
  {
    "iamcco/markdown-preview.nvim",
    config = function()
      vim.fn["mkdp#util#install"]()
     
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
