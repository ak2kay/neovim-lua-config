local present, tt = pcall(require, "toggleterm")

if not present then
   return
end

tt.setup {
   size = 20,
   hide_numbers = true,
   open_mapping = [[<C-\>]],
   shade_filetypes = {},
   shade_terminals = false,
   shading_factor = 0.3,
   start_in_insert = true,
   persist_size = true,
   direction = "horizontal",
}
