local present, legendary = pcall(require, "legendary")

if not present then
   return
end

legendary.setup { include_builtin = true, auto_register_which_key = true }

local keymap = utils_g.set_keymap
keymap("n", "<C-k>", "<cmd>lua require('legendary').find()<CR>")
