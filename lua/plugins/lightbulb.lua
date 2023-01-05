local M = { "kosayoda/nvim-lightbulb", event = "BufRead" }

function M.config()
   local lb = require "nvim-lightbulb"

   lb.setup { ignore = { "null-ls" } }
   vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
end

return M
