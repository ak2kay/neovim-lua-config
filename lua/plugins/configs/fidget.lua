local present, fidget = pcall(require, "fidget")

if not present then
   return
end

fidget.setup {
   -- sources = {
   --   ["null-ls"] = {
   --     ignore = true,
   --   },
   -- },
}
