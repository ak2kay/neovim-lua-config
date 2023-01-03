local M = {
   "ThePrimeagen/harpoon",
   dependencies = { "nvim-telescope/telescope.nvim" },
}

function M.config()
   local harpoon = require "harpoon"
   harpoon.setup {
      global_settings = { save_on_toggle = true, enter_on_sendcmd = true },
   }
   require("telescope").load_extension "harpoon"
end

return M
