local present, glance = pcall(require, "glance")

if not present then
   return
end

local actions = glance.actions
glance.setup {
   mappings = {
      list = {
         ["<leader>p"] = actions.enter_win "preview", -- Focus preview window
      },
   },
}

utils_g.set_keymap("n", "gD", "<CMD>Glance definitions<CR>")
utils_g.set_keymap("n", "gR", "<CMD>Glance references<CR>")
utils_g.set_keymap("n", "gY", "<CMD>Glance type_definitions<CR>")
utils_g.set_keymap("n", "gM", "<CMD>Glance implementations<CR>")
