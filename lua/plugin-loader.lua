local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if vim.fn.isdirectory(lazypath) == 0 then
   vim.notify("Installing lazy ...", vim.log.levels.INFO, { title = "lazy.nvim" })
   vim.fn.system { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath }
   vim.fn.system { "git", "-C", lazypath, "checkout", "tags/stable" } -- last stable release
   vim.notify("Lazy installed")
end

vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")
if not ok then
   vim.notify("Missing lazy.nvim, exiting..")
   return
end

lazy.setup("plugins", {
   git = {
      log = { "--since=3 days ago" }, -- show commits from the last 3 days
   },
   performance = {
      cache = {
         enabled = true,
         path = vim.fn.stdpath "cache" .. "/lazy/cache",
         -- Once one of the following events triggers, caching will be disabled.
         -- To cache all modules, set this to `{}`, but that is not recommended.
         -- The default is to disable on:
         --  * VimEnter: not useful to cache anything else beyond startup
         --  * BufReadPre: this will be triggered early when opening a file from the command line directly
         disable_events = { "VimEnter", "BufReadPre", "UIEnter" },
      },
      reset_packpath = true, -- reset the package path to improve startup time
      rtp = {
         reset = false,      -- reset the runtime path to $VIMRUNTIME and your config directory
         ---@type string[] list any plugins you want to disable here
         disabled_plugins = {
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
         },
      },
   },
})
