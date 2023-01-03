local M = { "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" }

function M.config()
   local keymap = utils_g.set_keymap
   keymap("n", "gma", "<cmd>CodeActionMenu<CR>")
   keymap("v", "gma", "<cmd>CodeActionMenu<CR>")
end

return M
