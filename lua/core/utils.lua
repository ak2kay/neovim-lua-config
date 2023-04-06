_G.utils_g = {}

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

-- load plugin after entering vim ui
utils_g.packer_lazy_load = function(plugin, timer)
   if plugin then
      timer = timer or 0
      vim.defer_fn(function()
         require("packer").loader(plugin)
      end, timer)
   end
end

-- print table
utils_g.print_table = function(tbl, indent)
  if not indent then indent = 0 end
  local toprint = string.rep(" ", indent) .. "{\r\n"
  indent = indent + 2 
  for k, v in pairs(tbl) do
    toprint = toprint .. string.rep(" ", indent)
    if (type(k) == "number") then
      toprint = toprint .. "[" .. k .. "] = "
    elseif (type(k) == "string") then
      toprint = toprint  .. k ..  "= "   
    end
    if (type(v) == "number") then
      toprint = toprint .. v .. ",\r\n"
    elseif (type(v) == "string") then
      toprint = toprint .. "\"" .. v .. "\",\r\n"
    elseif (type(v) == "table") then
      toprint = toprint .. utils_g.print_table(v, indent + 2) .. ",\r\n"
    else
      toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
    end
  end
  toprint = toprint .. string.rep(" ", indent-2) .. "}"
  return toprint
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
