utils_g.set_keymap("n", "<leader>h", "<C-W><C-H>")
utils_g.set_keymap("n", "<leader>l", "<C-W><C-L>")
utils_g.set_keymap("n", "<leader>k", "<C-W><C-K>")
utils_g.set_keymap("n", "<leader>j", "<C-W><C-J>")
utils_g.set_keymap("n", "H", "^")
utils_g.set_keymap("n", "L", "$")
utils_g.set_keymap("v", "J", "<C-d>")
utils_g.set_keymap("v", "K", "<C-u>")
utils_g.set_keymap("v", "H", "^")
utils_g.set_keymap("v", "L", "$")
utils_g.set_keymap("n", "<esc>", "<cmd>noh<CR>")
utils_g.set_keymap("t", "<esc>", "<C-\\><C-n>")
utils_g.set_keymap("i", "<C-a>", "<C-o>0")
utils_g.set_keymap("i", "<C-e>", "<C-o>$")
utils_g.set_keymap("n", "Y", "y$")
-- center search
utils_g.set_keymap("n", "n", "nzzzv")
utils_g.set_keymap("n", "N", "Nzzzv")
utils_g.set_keymap("n", "J", "mzJ`z")
-- breaking undo
utils_g.set_keymap("i", ",", ",<c-g>u")
utils_g.set_keymap("i", ".", ".<c-g>u")
-- moving text
utils_g.set_keymap("n", "<leader>sj", ":m .+1<CR>==")
utils_g.set_keymap("n", "<leader>sk", ":m .-2<CR>==")
utils_g.set_keymap("v", "J", ":m '>+1<CR>gv=gv")
utils_g.set_keymap("v", "K", ":m '<-2<CR>gv=gv")
utils_g.set_keymap("i", "<c-j>", "<esc>:m .+1<CR>==i")
utils_g.set_keymap("i", "<c-k>", "<esc>:m .-2<CR>==i")
-- paste last ting yanked, not deleted
utils_g.set_keymap("n", "<leader>P", '"0P')
utils_g.set_keymap("n", "<leader>p", '"0p')
-- write only if something is changed
utils_g.set_keymap("n", "<leader>u", "<cmd>up<CR>")
-- make *  highlight current work
utils_g.set_keymap("n", "*", ':execute "normal! *N"<cr>')
-- better indent
utils_g.set_keymap("v", "<", "<gv")
utils_g.set_keymap("v", ">", ">gv")
-- resizing panes
utils_g.set_keymap("n", "<Left>", ":vertical resize +1<CR>")
utils_g.set_keymap("n", "<Right>", ":vertical resize -1<CR>")
utils_g.set_keymap("n", "<Up>", ":resize -1<CR>")
utils_g.set_keymap("n", "<Down>", ":resize +1<CR>")
