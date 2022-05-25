local present, lb = pcall(require, "nvim-lightbulb")

if not present then
   return
end

lb.setup {
   ignore = { "null-ls" },
}
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
