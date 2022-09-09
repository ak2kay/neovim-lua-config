local autocmd = vim.api.nvim_create_autocmd

-- Disable statusline in dashboard
autocmd("FileType", {
   pattern = "alpha",
   callback = function()
      vim.opt.laststatus = 0
   end,
})

autocmd("BufUnload", {
   buffer = 0,
   callback = function()
      vim.opt.laststatus = 3
   end,
})

autocmd({ "BufNewFile", "BufRead" }, {
   pattern = "*.star",
   callback = function()
      vim.opt.filetype = "python"
   end,
})
