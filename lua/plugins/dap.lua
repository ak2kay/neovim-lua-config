return {
   "mfussenegger/nvim-dap",
   keys = { [[<leader>d]] },
   dependencies = {
      "alpha2phi/DAPInstall.nvim",
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "nvim-telescope/telescope-dap.nvim",
      "leoluz/nvim-dap-go",
      "jbyuki/one-small-step-for-vimkind",
   },
   config = function()
      require "plugins.dap"
   end,
}
