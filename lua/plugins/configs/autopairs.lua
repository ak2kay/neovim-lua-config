local present, npairs = pcall(require, "nvim-autopairs")

if not present then
   return
end

npairs.setup {
   check_ts = true,
}
npairs.add_rules(require "nvim-autopairs.rules.endwise-lua")
