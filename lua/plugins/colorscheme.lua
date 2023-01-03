return {
   {
      "mcchrish/zenbones.nvim",
      dependencies = "rktjmp/lush.nvim", -- https://github.com/rktjmp/lush.nvim
      config = function()
         vim.o.background = "light"
         vim.cmd [[colorscheme zenwritten]]
      end,
      enabled = false,
   },
   {
      "whatsthatsmell/codesmell_dark.vim",
      config = function()
         vim.cmd [[colorscheme codesmell_dark]]
      end,
      enabled = false,
   },
   {
      "sainnhe/gruvbox-material",
      config = function()
         vim.g.gruvbox_material_background = "soft"
         vim.cmd [[colorscheme gruvbox-material]]
      end,
      enabled = false,
   },
   {
      "relastle/bluewery.vim",
      config = function()
         vim.cmd [[colorscheme bluewery]]
      end,
      enabled = false,
   },
   {
      "sam4llis/nvim-tundra",
      config = function()
         vim.opt.background = "dark"
         vim.cmd "colorscheme tundra"
      end,
      priority = 1000, -- make sure colorscheme loads first
      enabled = true,
      lazy = false,
   },
   {
      "rebelot/kanagawa.nvim",
      config = function()
         vim.cmd [[colorscheme kanagawa]]
      end,
      enabled = false,
   },
   {
      "rose-pine/neovim",
      name = "rose-pine",
      config = function()
         vim.cmd "colorscheme rose-pine"
      end,
      enabled = false,
   },
   {
      "shaunsingh/nord.nvim",
      config = function()
         vim.cmd [[colorscheme nord]]
      end,
      enabled = false,
   },
}
