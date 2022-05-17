local lspconfig = require("lspconfig")

local M = {}

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local function get_json_schemas()
  local ok, schemas = pcall(require, "schemastore")
  if ok then
    return {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    }
  end
  return {}
end

local servers = {
  gopls = {},
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
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },
  tsserver = { disable_formatting = true },
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
  require("config.lsp.keymaps").setup(client, bufnr)

  -- Configure highlighting
  require("config.lsp.highlighter").setup(client)

  -- Configure formatting
  require("config.lsp.null-ls.formatters").setup(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

if PLUGINS.nvim_cmp.enabled then
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities) -- for nvim-cmp
end

local default_ops = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- Setup LSP handlers
require("config.lsp.handlers").setup()

function M.setup()
  for server_name, custom_opts in pairs(servers) do
    local opts = vim.tbl_deep_extend("force", default_ops, custom_opts)

    if server_name == "sumneko_lua" then
      opts = require("lua-dev").setup({ lspconfig = opts })
    end

    if PLUGINS.coq.enabled then
      local coq = require("coq")
      opts = coq.lsp_ensure_capabilities(opts)
    end

    if server_name == "rust_analyzer" then
      require("rust-tools").setup({
        server = opts,
      })
    elseif server_name == "tsserver" then
      require("typescript").setup({ server = opts })
    else
      lspconfig[server_name].setup(opts)
    end
  end
  -- null-ls
  require("config.lsp.null-ls").setup(default_ops)
end

return M
