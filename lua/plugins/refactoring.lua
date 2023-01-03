local M = {
   "ThePrimeagen/refactoring.nvim",
   dependencies = { "nvim-telescope/telescope.nvim" },
   keys = { [[<leader>r]] },
}

function M.config()
   local refactoring = require "refactoring"
   refactoring.setup {
      prompt_func_return_type = { go = true },
      prompt_func_param_type = { go = true },
   }
   require("telescope").load_extension "refactoring"
   -- remap to open the Telescope refactoring menu in visual mode
   vim.api.nvim_set_keymap(
      "v",
      "<leader>rr",
      "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
      { noremap = true }
   )
end

return M
