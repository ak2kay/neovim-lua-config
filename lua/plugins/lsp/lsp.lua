local lspconfig = require "lspconfig"

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
   jsonls = {
      settings = get_json_schemas(),
   },
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
   require("plugins.lsp.keymaps").setup(client, bufnr)

   -- Configure highlighting
   require("plugins.lsp.highlighter").setup(client)

   -- Configure formatting
   require("plugins.lsp.nullls.formatters").setup(client, bufnr)
end


local function setup()
   -- null-ls
   require("plugins.lsp.nullls.nullls").setup(default_opts)
end

setup()
