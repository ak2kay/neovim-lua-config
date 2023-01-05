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
   { "tpope/vim-surround", event = "VeryLazy" },
   { "andymass/vim-matchup", event = "BufRead" },
   { "wellle/targets.vim", event = "VeryLazy" },
   { "unblevable/quick-scope", enabled = false },
   { "chaoren/vim-wordmotion", event = "BufReadPre" },
   { "kazhala/close-buffers.nvim", cmd = { "BDelete", "BWipeout" } },
   {
      "kevinhwang91/nvim-hlslens",
      event = "BufReadPre",
      config = function()
         require("hlslens").setup()
      end,
   },
   {
      "antoinemadec/FixCursorHold.nvim",
      event = "BufReadPre",
      config = function()
         vim.g.cursorhold_updatetime = 100
      end,
   },
   {
      "b0o/incline.nvim",
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
      "windwp/nvim-ts-autotag",
      dependencies = "nvim-treesitter/nvim-treesitter",
      event = "InsertEnter",
      config = function()
         require("nvim-ts-autotag").setup { enabled = true }
      end,
   }, -- End wise
   {
      "RRethy/nvim-treesitter-endwise",
      dependencies = "nvim-treesitter/nvim-treesitter",
      event = "InsertEnter",
   },
   {
      "folke/neodev.nvim",
      lazy = true,
      config = function()
         require("neodev").setup {}
      end,
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
