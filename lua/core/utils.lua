_G.utils_g = {}

-- merge default/user plugin tables
utils_g.merge_plugins = function(default_plugins)
   local final_table = {}

   for key, _ in pairs(default_plugins) do
      default_plugins[key][1] = key

      final_table[#final_table + 1] = default_plugins[key]
   end

   return final_table
end

utils_g.set_keymap = function(mode, lhs, rhs, opts)
   local options = { noremap = true, silent = true }
   if opts then
      options = vim.tbl_extend("force", options, opts)
   end
   vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

utils_g.buf_set_keymap = function(bufnr, mode, lhs, rhs, opts)
   local options = { noremap = true, silent = true }
   if opts then
      options = vim.tbl_extend("force", options, opts)
   end
   vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

utils_g.log = function(msg, hl, name)
   name = name or "Neovim"
   hl = hl or "Todo"
   vim.api.nvim_echo({ { name .. ": ", hl }, { msg } }, true, {})
end

utils_g.warn = function(msg, name)
   vim.notify(msg, vim.log.levels.WARN, { title = name })
end

utils_g.error = function(msg, name)
   vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

utils_g.info = function(msg, name)
   vim.notify(msg, vim.log.levels.INFO, { title = name })
end
