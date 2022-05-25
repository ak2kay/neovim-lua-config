local present, _ = pcall(require, "spectre")

if not present then
   return
end

utils_g.set_keymap("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>")
