local opt = vim.opt

opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true --Set highlight on search
opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default
opt.mouse = "" --Disable mouse mode
opt.breakindent = true --Enable break indent
opt.undofile = true --Save undo history
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.updatetime = 100 --Decrease update time
opt.signcolumn = "yes" -- Always show sign column
opt.cmdheight = 2
opt.splitbelow = true
opt.splitright = true
opt.clipboard = "unnamedplus" -- Access system clipboard
opt.timeoutlen = 300 --	Time in milliseconds to wait for a mapped sequence to complete.
opt.showmode = false -- Do not need to show the mode. We use the statusline instead.
opt.scrolloff = 8 -- Lines of context
-- opt.scrolloff = 999 -- Lines of context
-- opt.sidescrolloff = 999
opt.joinspaces = false -- No double spaces with join after a dot
opt.laststatus = 3 -- Global statusline
opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

-- disable nvim intro
opt.shortmess:append("sI")

-- Better search
opt.path:remove("/usr/include")
opt.path:append("**")
-- vim.cmd [[set path=.,,,$PWD/**]] -- Set the path directly

opt.wildignorecase = true
opt.wildignore:append("**/node_modules/*")
opt.wildignore:append("**/.git/*")

opt.foldmethod = "expr"
opt.foldlevel = 5
opt.foldlevelstart = 5
opt.foldnestmax = 5
opt.foldexpr = "nvim_treesitter#foldexpr()"

opt.swapfile = false
opt.wrap = false
opt.autoread = true
opt.backup = false
opt.writebackup = false
