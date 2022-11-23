local lspconfig = require "lspconfig"

local M = {}

local function get_json_schemas()
   local ok, schemas = pcall(require, "schemastore")
   if ok then
      return {
         json = {
            schemas = schemas.json.schemas(),
         },
      }
   end
   return {}
end

local servers = {
   gopls = {},
   golangci_lint_ls = {},
   jsonls = {
      settings = get_json_schemas(),
   },
   pyright = {},
   rust_analyzer = {
      settings = {
         ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = {
               command = "clippy",
               extraArgs = { "--no-deps" },
            },
         },
      },
   },
   sumneko_lua = {
      settings = {
         Lua = {
            diagnostics = {
               -- Get the language server to recognize the `vim` global
               globals = { "vim", "utils_g" },
            },
            format = {
               -- default formatting ability provided by sumneko_lua will make annoying save issues.
               -- aka, :w won't work, even if you changed nothing.
               enable = false,
            },
         },
      },
   },
   -- tsserver is too slow, disable it for now.
   --[[ tsserver = { disable_formatting = true }, ]]
   yamlls = {},
}

-- local lsp_signature = require "lsp_signature"
-- lsp_signature.setup {
--   bind = true,
--   handler_opts = {
--     border = "rounded",
--   },
-- }

local function on_attach(client, bufnr)
   -- Enable completion triggered by <C-X><C-O>
   -- See `:help omnifunc` and `:help ins-completion` for more information.
   vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

   -- Use LSP as the handler for formatexpr.
   -- See `:help formatexpr` for more information.
   vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

   -- Configure key mappings
   require("plugins.configs.lsp.keymaps").setup(client, bufnr)

   -- Configure highlighting
   require("plugins.configs.lsp.highlighter").setup(client)

   -- Configure formatting
   require("plugins.configs.lsp.null-ls.formatters").setup(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities) -- for nvim-cmp

local default_ops = {
   on_attach = on_attach,
   capabilities = capabilities,
   flags = {
      debounce_text_changes = 150,
   },
}

-- Setup LSP handlers
require("plugins.configs.lsp.handlers").setup()

function M.setup()
   for server_name, custom_opts in pairs(servers) do
      local opts = vim.tbl_deep_extend("force", default_ops, custom_opts)

      if server_name == "rust_analyzer" then
         require("rust-tools").setup {
            server = opts,
         }
         --[[ elseif server_name == "tsserver" then ]]
         --[[    require("typescript").setup { server = opts } ]]
      else
         lspconfig[server_name].setup(opts)
      end
   end
   -- null-ls
   require("plugins.configs.lsp.null-ls").setup(default_ops)
end

return M
