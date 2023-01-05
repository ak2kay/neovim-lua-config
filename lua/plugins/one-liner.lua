return {
   "nathom/filetype.nvim",
   "nvim-lua/plenary.nvim",
   {
      "norcalli/nvim-colorizer.lua",
      cmd = "ColorizerToggle",
      config = function()
         require "colorizer"
      end,
   },
   { "ellisonleao/glow.nvim", cmd = { "Glow", "GlowInstall" } },
   {
      "rcarriga/nvim-notify",
      config = function()
         vim.notify = require "notify"
      end,
   },
   {
      "kyazdani42/nvim-web-devicons",
      config = function()
         require("nvim-web-devicons").setup { default = true }
      end,
   },
   { "tpope/vim-surround", event = "VeryLazy" }, -- Examples: cst": aka change surround to "; ds": aka delete surround "; cs"'; ysiw";
   { "andymass/vim-matchup", event = "BufRead" }, -- Even better % 👊 navigate and highlight matching words
   { "wellle/targets.vim", event = "VeryLazy" }, -- Provides additional text objects
   { "chaoren/vim-wordmotion", event = "BufReadPre" }, -- More useful word motions, like camelcase
   { "kazhala/close-buffers.nvim", cmd = { "BDelete", "BWipeout" } },
   {
      "kevinhwang91/nvim-hlslens",
      event = "BufReadPre",
      config = function()
         require("hlslens").setup()
      end,
   },
   {
      "b0o/incline.nvim", -- Floating statuslines for Neovim
      event = "BufReadPre",
      config = function()
         require("incline").setup()
      end,
   },
   {
      "stevearc/dressing.nvim",
      event = "BufReadPre",
      config = function()
         require("dressing").setup {
            input = { relative = "editor" },
            select = { backend = { "telescope", "fzf", "builtin" } },
         }
      end,
   },
   {
      "L3MON4D3/LuaSnip",
      lazy = true,
      dependencies = { "rafamadriz/friendly-snippets" },
      config = function()
         require("luasnip.loaders.from_vscode").lazy_load()
      end,
   },
   {
      "RRethy/nvim-treesitter-endwise", -- Wisely add "end" in Ruby, Vimscript, Lua, etc.
      dependencies = "nvim-treesitter/nvim-treesitter",
      event = "InsertEnter",
   },
   {
      "j-hui/fidget.nvim",
      event = "BufReadPre",
      config = function()
         require("fidget").setup {}
      end,
   },
   {
      "folke/trouble.nvim",
      dependencies = "kyazdani42/nvim-web-devicons",
      cmd = { "TroubleToggle", "Trouble" },
      config = function()
         require("trouble").setup { _diagnostic_signs = true }
      end,
   },
   {
      "ray-x/go.nvim",
      ft = { "go" },
      config = function()
         require("go").setup()
      end,
      dependencies = { "ray-x/guihua.lua" },
   },
   { "hotoo/pangu.vim", ft = { "markdown" } },
}
