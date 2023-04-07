local M = {}

local function lsp_keymaps(client, bufnr)
   local keymap = utils_g.set_keymap

   keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
   keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
   keymap("n", "gf", "<cmd>lua vim.lsp.buf.format()<CR>")
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

-- Highlight symbol under cursor
local function lsp_highlight(client, bufnr)
   if client.supports_method "textDocument/documentHighlight" then
      local present, illuminate = pcall(require, "illuminate")
      if present then
         illuminate.on_attach(client)
      else
         vim.api.nvim_create_augroup("lsp_document_highlight", {
            clear = false,
         })
         vim.api.nvim_clear_autocmds {
            buffer = bufnr,
            group = "lsp_document_highlight",
         }
         vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
         })
         vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
         })
      end
   end
end

local function disable_format_on_save()
   vim.api.nvim_del_augroup_by_name "Format on save"
   vim.notify("Format on save is now disabled", vim.log.levels.INFO, { title = "Format" })
end

local function enable_format_on_save()
   vim.api.nvim_create_augroup("Format on save", { clear = false })
   vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
         vim.lsp.buf.format {
            async = true,
            filter = function(client)
               -- if client.supports_method "textDocument/formatting" then
               --   return client.name ~= "null-ls"
               -- end
               return client.name == "null-ls"
            end,
         }
         vim.notify("Format Done", vim.log.levels.INFO, { title = "Format" })
      end,
      group = "Format on save",
   })
   vim.notify("Format on save is now enabled", vim.log.levels.INFO, { title = "Format" })
end

local cmp_nvim_lsp = require "cmp_nvim_lsp"
--[[ local capabilities = vim.lsp.protocol.make_client_capabilities() ]]
--[[ capabilities.textDocument.completion.completionItem.snippetSupport = true ]]
--[[ capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities) -- for nvim-cmp ]]
M.capabilities = cmp_nvim_lsp.default_capabilities()

M.setup = function()
   local signs = { Error = "", Warn = "", Hint = "", Info = "" }
   for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
   end

   local config = {
      -- Enable virtual text
      virtual_text = true,
      -- show signs
      signs = {
         active = signs,
      },
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
         focusable = false,
         style = "minimal",
         border = "rounded",
         source = "always",
         header = "",
         prefix = "",
      },
   }

   vim.diagnostic.config(config)

   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
   })

   vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
   })
end

M.on_attach = function(client, bufnr)
   lsp_keymaps(client, bufnr)
   lsp_highlight(client, bufnr)
   vim.api.nvim_create_user_command("FormatOnSaveToggle", function()
      if vim.fn.exists "#Format on save#BufWritePre" == 0 then
         enable_format_on_save()
      else
         disable_format_on_save()
      end
   end, { nargs = "*" })
end

return M
