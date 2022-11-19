local plugins = {

   -- Performance
   ["lewis6991/impatient.nvim"] = {},
   ["nathom/filetype.nvim"] = {},
   ["dstein64/vim-startuptime"] = { cmd = "StartupTime" },

   ["nvim-lua/plenary.nvim"] = {},
   ["wbthomason/packer.nvim"] = {},

   -- Startup screen
   ["goolord/alpha-nvim"] = {
      config = function()
         require "plugins.configs.alpha"
      end,
   },

   -- Colorscheme
   ["mcchrish/zenbones.nvim"] = {
      requires = "rktjmp/lush.nvim", -- https://github.com/rktjmp/lush.nvim
      config = function()
         vim.o.background = "light"
         vim.cmd [[colorscheme zenwritten]]
      end,
      disable = false,
   },
   ["whatsthatsmell/codesmell_dark.vim"] = {
      config = function()
         vim.cmd [[colorscheme codesmell_dark]]
      end,
      disable = true,
   },
   ["sainnhe/gruvbox-material"] = {
      config = function()
         vim.g.gruvbox_material_background = "soft"
         vim.cmd [[colorscheme gruvbox-material]]
      end,
      disable = true,
   },
   ["relastle/bluewery.vim"] = {
      config = function()
         vim.cmd [[colorscheme bluewery]]
      end,
      disable = true,
   },
   ["sam4llis/nvim-tundra"] = {
      config = function()
         vim.opt.background = "dark"
         vim.cmd "colorscheme tundra"
      end,
      disable = true,
   },
   ["rebelot/kanagawa.nvim"] = {
      config = function()
         vim.cmd [[colorscheme kanagawa]]
      end,
      disable = true,
   },
   ["rose-pine/neovim"] = {
      as = "rose-pine",
      config = function()
         vim.cmd "colorscheme rose-pine"
      end,
      disable = true,
   },

   ["norcalli/nvim-colorizer.lua"] = {
      cmd = "ColorizerToggle",
      config = function()
         require "colorizer"
      end,
   },

   -- Enhance
   ["dyng/ctrlsf.vim"] = {
      cmd = { "CtrlSF" },
      keys = { [[<leader>rw]] },
      config = function()
         require "plugins.configs.ctrlsf"
      end,
   },
   -- yank through ssh
   ["ojroques/vim-oscyank"] = {
      cmd = "OSCYank",
      keys = { [[<leader>c]] },
      fn = { "OSCYankString" },
      config = function()
         require "plugins.configs.oscyank"
      end,
   },
   ["ellisonleao/glow.nvim"] = {
      cmd = { "Glow", "GlowInstall" },
   },
   ["liuchengxu/vista.vim"] = {
      cmd = "Vista",
      keys = { [[<c-l>]] },
      config = function()
         require "plugins.configs.vista"
      end,
   },
   -- Notification
   ["rcarriga/nvim-notify"] = {
      config = function()
         vim.notify = require "notify"
      end,
   },
   -- Git
   ["TimUntersberger/neogit"] = {
      cmd = "Neogit",
      config = function()
         require "plugins.configs.neogit"
      end,
   },
   ["lewis6991/gitsigns.nvim"] = {
      event = "BufReadPre",
      wants = "plenary.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
         require "plugins.configs.gitsigns"
      end,
   },
   ["tpope/vim-fugitive"] = {
      cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" },
      requires = { "tpope/vim-rhubarb" },
   },
   ["ruifm/gitlinker.nvim"] = {
      keys = { [[<leader>gy]] },
      module = "gitlinker",
      after = "vim-oscyank",
      requires = { "ojroques/vim-oscyank", "nvim-lua/plenary.nvim" },
      config = function()
         require "plugins.configs.gitlinker"
      end,
   },

   -- IndentLine
   ["lukas-reineke/indent-blankline.nvim"] = {
      event = "BufReadPre",
      config = function()
         require "plugins.configs.indentblankline"
      end,
   },

   -- Better icons
   ["kyazdani42/nvim-web-devicons"] = {
      module = "nvim-web-devicons",
      config = function()
         require("nvim-web-devicons").setup { default = true }
      end,
   },

   -- Better Comment
   ["numToStr/Comment.nvim"] = {
      keys = { "gc", "gcc", "gbc" },
      config = function()
         require "plugins.configs.comment"
      end,
   },
   -- Better surround
   ["tpope/vim-surround"] = {
      opt = true,
      setup = function()
         utils_g.packer_lazy_load "vim-surround"
      end,
   },
   -- Motions
   -- better % match
   ["andymass/vim-matchup"] = {
      opt = true,
      setup = function()
         utils_g.packer_lazy_load "vim-matchup"
      end,
   },
   -- additional text objects
   ["wellle/targets.vim"] = {
      opt = true,
      setup = function()
         utils_g.packer_lazy_load "targets.vim"
      end,
   },
   ["unblevable/quick-scope"] = {
      opt = true,
      setup = function()
         utils_g.packer_lazy_load "quick-scope"
      end,
      disable = true,
   },
   ["chaoren/vim-wordmotion"] = { opt = true, fn = { "<Plug>WordMotion_w" } },
   -- Buffer
   ["kazhala/close-buffers.nvim"] = { cmd = { "BDelete", "BWipeout" } },
   ["kevinhwang91/nvim-hlslens"] = {
      event = "BufReadPre",
      disable = false,
      config = function()
         require("hlslens").setup()
      end,
   },
   ["nvim-pack/nvim-spectre"] = {
      keys = { [[<leader>sw]], [[<leader>sp]] },
      config = function()
         require "plugins.configs.spectre"
      end,
   },

   -- IDE
   ["antoinemadec/FixCursorHold.nvim"] = {
      event = "BufReadPre",
      config = function()
         vim.g.cursorhold_updatetime = 100
      end,
   },
   ["karb94/neoscroll.nvim"] = {
      event = "BufReadPre",
      config = function()
         require "plugins.configs.neoscroll"
      end,
      disable = true,
   },

   -- Status line
   ["nvim-lualine/lualine.nvim"] = {
      after = "nvim-treesitter",
      config = function()
         require "plugins.configs.lualine"
      end,
      wants = "nvim-web-devicons",
   },
   ["SmiteshP/nvim-gps"] = {
      requires = "nvim-treesitter/nvim-treesitter",
      module = "nvim-gps",
      wants = "nvim-treesitter",
      config = function()
         require("nvim-gps").setup()
      end,
   },
   ["b0o/incline.nvim"] = {
      event = "BufReadPre",
      config = function()
         require "incline"
      end,
   },

   -- Treesitter
   ["nvim-treesitter/nvim-treesitter"] = {
      opt = true,
      event = "BufRead",
      run = ":TSUpdate",
      config = function()
         require "plugins.configs.treesitter"
      end,
      requires = {
         { "nvim-treesitter/nvim-treesitter-textobjects" },
         "windwp/nvim-ts-autotag",
         "JoosepAlviste/nvim-ts-context-commentstring",
      },
   },

   ["nvim-telescope/telescope.nvim"] = {
      opt = true,
      config = function()
         require "plugins.configs.telescope"
      end,
      cmd = { "Telescope" },
      module = { "telescope", "telescope.builtin" },
      keys = { [[<c-p>]] },
      wants = {
         "plenary.nvim",
         "popup.nvim",
         "telescope-fzf-native.nvim",
         "telescope-project.nvim",
         "telescope-repo.nvim",
         "telescope-file-browser.nvim",
         "project.nvim",
         "trouble.nvim",
         "telescope-dap.nvim",
         "telescope-frecency.nvim",
      },
      requires = {
         "nvim-lua/popup.nvim",
         "nvim-lua/plenary.nvim",
         { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
         "nvim-telescope/telescope-project.nvim",
         "cljoly/telescope-repo.nvim",
         "nvim-telescope/telescope-file-browser.nvim",
         { "nvim-telescope/telescope-frecency.nvim", requires = "tami5/sqlite.lua" },
         {
            "ahmedkhalf/project.nvim",
            config = function()
               require "plugins.configs.project"
            end,
         },
         "nvim-telescope/telescope-dap.nvim",
      },
   },

   -- nvim-tree
   ["kyazdani42/nvim-tree.lua"] = {
      opt = true,
      ft = "alpha",
      wants = "nvim-web-devicons",
      cmd = { "NvimTreeToggle", "NvimTreeClose" },
      module = "nvim-tree",
      config = function()
         require "plugins.configs.nvimtree"
      end,
   },
   -- Buffer line
   ["akinsho/nvim-bufferline.lua"] = {
      event = "BufReadPre",
      wants = "nvim-web-devicons",
      config = function()
         require "plugins.configs.bufferline"
      end,
   },

   -- interface
   ["stevearc/dressing.nvim"] = {
      event = "BufReadPre",
      config = function()
         require("dressing").setup {
            input = { relative = "editor" },
            select = {
               backend = { "telescope", "fzf", "builtin" },
            },
         }
      end,
      disable = false,
   },

   ["hrsh7th/nvim-cmp"] = {
      event = "InsertEnter",
      opt = true,
      config = function()
         require "plugins.configs.cmp"
      end,
      wants = { "LuaSnip" },
      requires = {
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-path",
         "hrsh7th/cmp-nvim-lua",
         "ray-x/cmp-treesitter",
         "hrsh7th/cmp-cmdline",
         "octaltree/cmp-look", -- https://github.com/octaltree/cmp-look
         "saadparwaiz1/cmp_luasnip",
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-nvim-lsp-signature-help",
         {
            "L3MON4D3/LuaSnip",
            wants = { "friendly-snippets" },
            config = function()
               require("luasnip.loaders.from_vscode").lazy_load()
            end,
         },
         "rafamadriz/friendly-snippets",
      },
   },

   -- Auto pairs
   ["windwp/nvim-autopairs"] = {
      wants = "nvim-treesitter",
      module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
      config = function()
         require "plugins.configs.autopairs"
      end,
   },

   ["windwp/nvim-ts-autotag"] = {
      wants = "nvim-treesitter",
      event = "InsertEnter",
      config = function()
         require("nvim-ts-autotag").setup { enable = true }
      end,
   },
   -- End wise
   ["RRethy/nvim-treesitter-endwise"] = {
      wants = "nvim-treesitter",
      event = "InsertEnter",
      disable = false,
   },
   ["neovim/nvim-lspconfig"] = {
      opt = true,
      event = "BufRead",
      wants = {
         "nvim-lsp-installer",
         "cmp-nvim-lsp",
         "neodev.nvim",
         "vim-illuminate",
         "null-ls.nvim",
         "typescript.nvim",
         "goto-preview", -- https://github.com/rmagatti/goto-preview
         "nvim-code-action-menu", -- https://github.com/weilbith/nvim-code-action-menu
         "nvim-lightbulb",
         "schemastore.nvim",
      },
      config = function()
         require("nvim-lsp-installer").setup {
            ensure_installed = { "rust_analyzer", "sumneko_lua", "gopls", "tsserver", "yamlls" },
            automatic_installation = true,
         }
         require("plugins.configs.lsp").setup()
      end,
      requires = {
         "williamboman/nvim-lsp-installer",
         {
            "folke/neodev.nvim",
            config = function()
               require("neodev").setup {}
            end,
         },
         "RRethy/vim-illuminate",
         "jose-elias-alvarez/null-ls.nvim",
         {
            "j-hui/fidget.nvim",
            config = function()
               require "plugins.configs.fidget"
               require "fidget"
            end,
         },
         "jose-elias-alvarez/typescript.nvim",
         {
            "rmagatti/goto-preview",
            config = function()
               require "plugins.configs.goto-preview"
            end,
         }, -- https://github.com/rmagatti/goto-preview
         {
            "weilbith/nvim-code-action-menu",
            cmd = "CodeActionMenu",
            config = function()
               require "plugins.configs.code-action-menu"
            end,
         }, -- https://github.com/weilbith/nvim-code-action-menu
         {
            "kosayoda/nvim-lightbulb",
            config = function()
               require "plugins.configs.lightbulb"
            end,
         },
         "b0o/schemastore.nvim",
      },
   },

   -- trouble.nvim
   ["folke/trouble.nvim"] = {
      wants = "nvim-web-devicons",
      cmd = { "TroubleToggle", "Trouble" },
      config = function()
         require("trouble").setup {
            _diagnostic_signs = true,
         }
      end,
   },

   -- Rust
   ["simrat39/rust-tools.nvim"] = {
      requires = { "nvim-lua/plenary.nvim", "rust-lang/rust.vim" },
      opt = true,
      module = "rust-tools",
      ft = { "rust" },
      config = function()
         require "plugins.configs.rust"
      end,
   },

   -- Go
   ["ray-x/go.nvim"] = {
      ft = { "go" },
      config = function()
         require("go").setup()
      end,
      requires = {
         "ray-x/guihua.lua",
      },
   },

   -- Terminal
   ["akinsho/toggleterm.nvim"] = {
      keys = { [[<C-\>]] },
      cmd = { "ToggleTerm", "TermExec" },
      config = function()
         require "plugins.configs.toggleterm"
      end,
   },

   -- Debugging
   ["mfussenegger/nvim-dap"] = {
      opt = true,
      -- event = "BufReadPre",
      keys = { [[<leader>d]] },
      module = { "dap" },
      wants = { "nvim-dap-virtual-text", "DAPInstall.nvim", "nvim-dap-ui", "nvim-dap-python" },
      requires = {
         "alpha2phi/DAPInstall.nvim",
         "theHamsta/nvim-dap-virtual-text",
         "rcarriga/nvim-dap-ui",
         "mfussenegger/nvim-dap-python",
         "nvim-telescope/telescope-dap.nvim",
         { "leoluz/nvim-dap-go", module = "dap-go" },
         { "jbyuki/one-small-step-for-vimkind", module = "osv" },
      },
      config = function()
         require "plugins.configs.dap"
      end,
   },

   -- AI completion
   ["github/copilot.vim"] = {
      -- This ensures that in insert mode, telescope.nvim will no longer complain about keymap assert errors when
      -- pressing tab.
      after = "telescope.nvim",
      config = function()
         require "plugins.configs.copilot"
      end,
      disable = true,
   },

   -- Legendary
   ["mrjones2014/legendary.nvim"] = {
      opt = true,
      keys = { [[<C-k>]] },
      wants = { "dressing.nvim" },
      config = function()
         require "plugins.configs.legendary"
      end,
      requires = { "stevearc/dressing.nvim" },
   },

   -- Harpoon can add marks for frequently used files, and jump to them quickly.
   ["ThePrimeagen/harpoon"] = { -- https://github.com/ThePrimeagen/harpoon
      module = { "harpoon", "harpoon.cmd-ui", "harpoon.mark", "harpoon.ui", "harpoon.term" },
      wants = { "telescope.nvim" },
      config = function()
         require "plugins.configs.harpoon"
      end,
   },

   -- Refactoring can extract funciton from selected codes.
   ["ThePrimeagen/refactoring.nvim"] = { -- https://github.com/ThePrimeagen/refactoring.nvim
      module = { "refactoring", "telescope" },
      keys = { [[<leader>r]] },
      wants = { "telescope.nvim" },
      config = function()
         require "plugins.configs.refactoring"
      end,
   },

   ["hotoo/pangu.vim"] = {
      opt = true,
      ft = { "markdown" },
   },
}

require("core.packer").run(plugins)
