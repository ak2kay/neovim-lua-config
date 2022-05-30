local present, nvimtree = pcall(require, "nvim-tree")

if not present then
   return
end

local options = {
   filters = {
      dotfiles = false,
      custom = { ".git", "node_modules" },
   },
   disable_netrw = true,
   hijack_netrw = true,
   ignore_ft_on_setup = { "alpha" },
   open_on_tab = false,
   hijack_cursor = true,
   hijack_unnamed_buffer_when_opening = false,
   update_cwd = true,
   update_focused_file = {
      enable = true,
      update_cwd = true,
   },
   view = {
      side = "left",
      width = 25,
      hide_root_folder = true,
   },
   git = {
      enable = false,
      ignore = true,
   },
   actions = {
      open_file = {
         resize_window = true,
      },
   },
   renderer = {
      add_trailing = true,
      highlight_git = false,
      highlight_opened_files = "all",
      indent_markers = {
         enable = false,
      },
      icons = {
         show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
         },
         glyphs = {
            default = "",
            symlink = "",
            folder = {
               default = "",
               empty = "",
               empty_open = "",
               open = "",
               symlink = "",
               symlink_open = "",
               arrow_open = "",
               arrow_closed = "",
            },
            git = {
               deleted = "",
               ignored = "◌",
               renamed = "➜",
               staged = "✓",
               unmerged = "",
               unstaged = "✗",
               untracked = "★",
            },
         },
      },
   },
}

nvimtree.setup(options)

utils_g.set_keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
utils_g.set_keymap("n", "<leader>f", "<cmd>NvimTreeFocus<CR>")
