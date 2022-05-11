local M = {}

function M.setup()
  require("nvim-lightbulb").setup({
    ignore = { "null-ls" },
  })
  vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
end

return M
