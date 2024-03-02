return {
  "rcarriga/nvim-notify",
  module = "notify",
  config = function()
    require("notify").setup({
      stages = "fade",
      render = "wrapped-compact",
      max_width = 50,
      min_width = 50,
      timeout = 3000,
      top_down = true,
      background_colour = "NotifyBackground",
      text_colour = "#ffffff",
      icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
      },
    })
  end,
}
