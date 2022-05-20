local M = {}

local function keymaps(client, bufnr)
  local keymap = require("utils").set_keymap
  local buf_keymap = require("utils").buf_set_keymap

  buf_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  buf_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  buf_keymap(bufnr, "n", "gf", "<cmd>lua vim.lsp.buf.formatting()<CR>")
  keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
  keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
  keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>")
  keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>")

  -- toggle buffer diagnostic
  local buf_diagnostics_active = true
  vim.keymap.set("n", "<leader>bd", function()
    buf_diagnostics_active = not buf_diagnostics_active
    if buf_diagnostics_active then
      vim.diagnostic.show(nil, 0)
    else
      vim.diagnostic.hide(nil, 0)
    end
  end)
  -- toggle workspace diagnostic
  local diagnostics_active = true
  vim.keymap.set("n", "<leader>bd", function()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
      vim.diagnostic.show()
    else
      vim.diagnostic.hide()
    end
  end)
end

function M.setup(client, bufnr)
  keymaps(client, bufnr)
end

return M
