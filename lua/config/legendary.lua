local M = {}

local function keymaps()
  local keymap = require("utils").set_keymap
  keymap("n", "<C-k>", "<cmd>lua require('legendary').find()<CR>")
end

function M.setup()
  require("legendary").setup({ include_builtin = true, auto_register_which_key = true })

  keymaps()
end

return M
