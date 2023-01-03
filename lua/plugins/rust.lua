local M = {
   "simrat39/rust-tools.nvim",
   dependencies = { "nvim-lua/plenary.nvim", "rust-lang/rust.vim" },
   ft = { "rust" },
}

function M.config()
   local rt = require "rust-tools"
   -- local dbg_path = require("dap-install.config.settings").options["installation_path"] .. "codelldb/"
   -- local codelldb_path = dbg_path .. "extension/adapter/codelldb"
   -- local liblldb_path = dbg_path .. "extension/lldb/lib/liblldb.so"
   local opts = {}
   -- local opts = {
   --    dap = {
   --       adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
   --    },
   -- }
   rt.setup { opts }
end

return M
