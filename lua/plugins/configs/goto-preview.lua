local present, gp = pcall(require, "goto-preview")

if not present then
   return
end

gp.setup {}

local keymap = utils_g.set_keymap
keymap("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>")
keymap("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
keymap("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>")
keymap("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>")
