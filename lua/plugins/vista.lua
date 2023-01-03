local M = { "liuchengxu/vista.vim", cmd = "Vista", keys = { [[<c-l>]] } }

function M.config()
   vim.g["vista_default_executive"] = "nvim_lsp"

   utils_g.set_keymap("n", "<C-l>", ":Vista!!<CR>")
end

return M
