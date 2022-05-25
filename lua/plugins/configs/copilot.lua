local g = vim.g

g["copilot_no_tab_map"] = true
g["copilot_assume_mapped"] = true
g.copilot_filetypes = {
   ["*"] = false,
   ["javascript"] = true,
   ["typescript"] = true,
   ["lua"] = false,
   ["rust"] = true,
   ["c"] = true,
   ["c#"] = true,
   ["c++"] = true,
   ["go"] = true,
   ["python"] = true,
}

utils_g.set_keymap("i", "<C-y>", 'copilot#Accept("<CR>")', { expr = true })
