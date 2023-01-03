local M = { "rmagatti/goto-preview" }

function M.config()
   local gp = require "goto-preview"

   gp.setup {}

   local keymap = utils_g.set_keymap
   keymap("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>")
   keymap("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
   keymap("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>")
   keymap("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>")
end

return M
