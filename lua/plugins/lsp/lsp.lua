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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities) -- for nvim-cmp

local default_opts = {
   on_attach = on_attach,
   capabilities = capabilities,
   flags = {
      debounce_text_changes = 150,
   },
}

local function merge_opts(server_name)
   local custom_opts = {}
   if servers[server_name] ~= nil then
      custom_opts = servers[server_name]
   end
   return vim.tbl_deep_extend("force", default_opts, custom_opts)
end

local function setup()
   -- Setup LSP handlers
   require("plugins.lsp.handlers").setup()

   -- Setup LSP hanlers using mason
   require("mason-lspconfig").setup_handlers {
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      function(server_name) -- default handler (optional)
         require("lspconfig")[server_name].setup { merge_opts(server_name) }
      end,
      -- Next, you can provide a dedicated handler for specific servers.
      -- For example, a handler override for the `rust_analyzer`:
      ["rust_analyzer"] = function()
         require("rust-tools").setup { merge_opts "rust_analyzer" }
      end,
   }
   -- null-ls
   require("plugins.lsp.nullls.nullls").setup(default_opts)
end

setup()
