local M = {
   "neovim/nvim-lspconfig",
   event = "BufRead",
   dependencies = {
      "williamboman/mason.nvim",
      "folke/neodev.nvim",
      "RRethy/vim-illuminate",
      "jose-elias-alvarez/null-ls.nvim",
      "j-hui/fidget.nvim",
      "jose-elias-alvarez/typescript.nvim",
      "rmagatti/goto-preview",
      "weilbith/nvim-code-action-menu",
      "kosayoda/nvim-lightbulb",
      "b0o/schemastore.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
   },
}

function M.config()
   require "plugins.lsp.lsp"
end

return M
