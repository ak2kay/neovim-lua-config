_G.dump = function(...)
   print(vim.inspect(...))
end

_G.prequire = function(...)
   local status, lib = pcall(require, ...)
   if status then
      return lib
   end
   return nil
end

local M = {}

function M.set_keymap(mode, lhs, rhs, opts)
   local options = { noremap = true, silent = true }
   if opts then
      options = vim.tbl_extend("force", options, opts)
   end
   vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.buf_set_keymap(bufnr, mode, lhs, rhs, opts)
   local options = { noremap = true, silent = true }
   if opts then
      options = vim.tbl_extend("force", options, opts)
   end
   vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

function M.dump(o)
   if type(o) == "table" then
      local s = "{ "
      for k, v in pairs(o) do
         if type(k) ~= "number" then
            k = '"' .. k .. '"'
         end
         s = s .. "[" .. k .. "] = " .. M.dump(v) .. ","
      end
      return s .. "} "
   else
      return tostring(o)
   end
end

function M.t(str)
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.exists(list, val)
   local set = {}
   for _, l in ipairs(list) do
      set[l] = true
   end
   return set[val]
end

function M.log(msg, hl, name)
   name = name or "Neovim"
   hl = hl or "Todo"
   vim.api.nvim_echo({ { name .. ": ", hl }, { msg } }, true, {})
end

function M.warn(msg, name)
   vim.notify(msg, vim.log.levels.WARN, { title = name })
end

function M.error(msg, name)
   vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

function M.info(msg, name)
   vim.notify(msg, vim.log.levels.INFO, { title = name })
end

-- function M.nvim_version(val)
--   local version = (vim.version().major .. "." .. vim.version().minor) + 0.0
--   val = val or 0.7
--   if version >= val then
--     return true
--   else
--     return false
--   end
-- end
--
-- function M.nvim_nightly()
--   return M.nvim_version(0.7)
-- end

return M