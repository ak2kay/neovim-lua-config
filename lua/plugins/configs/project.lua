local present, pn = pcall(require, "project_nvim")

if not present then
   return
end

pn.setup {
   detection_methods = { "pattern", "lsp" },
   patterns = { ".git" },
}
