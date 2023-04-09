local g = vim.g
local opt = vim.opt

g.did_load_filetypes = 0
g.do_filetype_lua = 1

opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true --Set highlight on search
-- numbers
opt.number = true --Make line numbers default
opt.numberwidth = 2 -- minimum number column width
opt.relativenumber = true --Make relative number default
opt.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

opt.confirm = true
opt.title = true
-- disable tilde on end of buffer: https://github.com/neovim/neovim/pull/8546#issuecomment-643643758
opt.fillchars = { eob = " " }

opt.mouse = "" --Disable mouse mode
opt.breakindent = true --Enable break indent
opt.smartindent = true -- smart indent when start a new line
opt.undofile = true --Save undo history
opt.hidden = true
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.laststatus = 3 -- global statusline
opt.colorcolumn = "80" -- ruler
opt.cursorline = true -- highlight current line
opt.updatetime = 100 --Decrease update time
opt.signcolumn = "yes" -- Always show sign column
opt.cmdheight = 1
opt.splitbelow = true
opt.splitright = true
opt.clipboard = "unnamedplus" -- Access system clipboard
opt.timeoutlen = 300 --	Time in milliseconds to wait for a mapped sequence to complete.
opt.showmode = false -- Do not need to show the mode. We use the statusline instead.
opt.scrolloff = 8 -- Lines of context
-- opt.scrolloff = 999 -- Lines of context
-- opt.sidescrolloff = 999
opt.joinspaces = false -- No double spaces with join after a dot
opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- disable nvim intro
opt.shortmess:append "sI"

-- Better search
opt.path:remove "/usr/include"
opt.path:append "**"
-- vim.cmd [[set path=.,,,$PWD/**]] -- Set the path directly

-- better diff view, see: https://github.com/neovim/neovim/pull/14537
vim.cmd [[set diffopt+=linematch:50]]

opt.wildignorecase = true
opt.wildignore:append "**/node_modules/*"
opt.wildignore:append "**/.git/*"

opt.foldmethod = "expr"
opt.foldlevel = 5
opt.foldlevelstart = 5
opt.foldnestmax = 5
opt.foldexpr = "nvim_treesitter#foldexpr()"

opt.compatible = false
opt.swapfile = false
opt.wrap = false
opt.autoread = true
opt.backup = false
opt.writebackup = false

-- Disable some builtin vim plugins
local default_plugins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
}

for _, plugin in pairs(default_plugins) do
   g["loaded_" .. plugin] = 1
end

-- share between nvim instance
vim.schedule(function()
   vim.opt.shadafile = vim.fn.expand "$HOME" .. "/.local/share/nvim/shada/main.shada"
   vim.cmd [[ silent! rsh ]]
end)

-- remove clipboard provider check to speed up nvim startup
g.loaded_clipboard_provider = 1

g.mapleader = " "
