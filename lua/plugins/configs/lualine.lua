local present, lualine = pcall(require, "lualine")

if not present then
   return
end

local function separator()
   return "%="
end

local function lsp_client(msg)
   msg = msg or ""
   local buf_clients = vim.lsp.buf_get_clients()
   if next(buf_clients) == nil then
      if type(msg) == "boolean" or #msg == 0 then
         return ""
      end
      return msg
   end

   local buf_ft = vim.bo.filetype
   local buf_client_names = {}

   -- add client
   for _, client in pairs(buf_clients) do
      if client.name ~= "null-ls" then
         table.insert(buf_client_names, client.name)
      end
   end

   -- add formatter
   local formatters = require "plugins.configs.lsp.null-ls.formatters"
   local supported_formatters = formatters.list_registered(buf_ft)
   vim.list_extend(buf_client_names, supported_formatters)

   -- add linter
   local linters = require "plugins.configs.lsp.null-ls.linters"
   local supported_linters = linters.list_registered(buf_ft)
   vim.list_extend(buf_client_names, supported_linters)

   -- add hover
   local hovers = require "plugins.configs.lsp.null-ls.hovers"
   local supported_hovers = hovers.list_registered(buf_ft)
   vim.list_extend(buf_client_names, supported_hovers)

   -- add code action
   local code_actions = require "plugins.configs.lsp.null-ls.code_actions"
   local supported_code_actions = code_actions.list_registered(buf_ft)
   vim.list_extend(buf_client_names, supported_code_actions)

   local hash = {}
   local client_names = {}
   for _, v in ipairs(buf_client_names) do
      if not hash[v] then
         client_names[#client_names + 1] = v
         hash[v] = true
      end
   end
   table.sort(client_names)

   return "[" .. table.concat(client_names, ",") .. "]"
end

local gps = require "nvim-gps"

local config = {
   options = {
      section_separators = { "", "" },
      component_separators = { "", "" },
      theme = "auto",
      -- always_divide_middle = true,
   },
   sections = {
      lualine_c = {
         { "filename", file_status = true, path = 1 },
      },
   },
}

local function ins_left(component)
   table.insert(config.sections.lualine_c, component)
end

ins_left { separator }

ins_left {
   -- Lsp server name
   lsp_client,
   icon = " LSP:",
   color = { fg = "#000000", gui = "bold" },
}
ins_left {
   gps.get_location,
   cond = gps.is_available,
   color = { fg = "#ffffff" },
}

lualine.setup(config)
