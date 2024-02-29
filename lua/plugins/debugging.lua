return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "leoluz/nvim-dap-go", -- Example for .go files
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    require("dapui").setup()
    require("dap-go").setup() -- Example for .go files

    local dap, dapui = require("dap"), require("dapui")

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
 -- Custom which-key remappings
    local wk = require("which-key")
wk.register({
  ["<leader>d"] = {"Debugging"},
  ["<leader>dt"] = {"Toggle Breakpoint"},
  ["<leader>dc"] = {"Start Debugging"},
  ["<leader>dx"] = {"Stop Debugging"},
  ["<leader>do"] = {"Step Over"},
})


  end,
}
