return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    --  Custom which-key descriptions
    require("which-key").register({
      ["C"] = { "Quick Actions" },
      ["C-n"] = { "Neo-Tree" },
    })
  end,
}
