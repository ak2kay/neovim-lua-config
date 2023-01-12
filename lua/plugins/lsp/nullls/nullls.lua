local M = {}

local nls = require "null-ls"
local nls_utils = require "null-ls.utils"
local b = nls.builtins

local with_diagnostics_code = function(builtin)
   return builtin.with {
      diagnostics_format = "[#{c}] #{m} (#{s})",
   }
end

--[[ local with_root_file = function(builtin, file) ]]
--[[    return builtin.with { ]]
--[[       condition = function(utils) ]]
--[[          return utils.root_has_file(file) ]]
--[[       end, ]]
--[[    } ]]
--[[ end ]]

local sources = {
   -- formatting
   b.formatting.prettierd,
   b.formatting.shfmt, -- A shell parser, formatter, and interpreter with bash support.
   b.formatting.fixjson, -- A shell parser, formatter, and interpreter with bash support.
   b.formatting.black.with { extra_args = { "--fast" } }, -- The uncompromising Python code formatter.
   b.formatting.isort, -- Python utility / library to sort imports alphabetically and automatically separate them into sections and by type.
   b.formatting.stylua, -- An opinionated code formatter for Lua.
   b.formatting.gofumpt, -- Enforce a stricter format than gofmt, while being backwards compatible. That is, gofumpt is happy with a subset of the formats that gofmt is happy with.
   b.formatting.goimports, -- Updates your Go import lines, adding missing ones and removing unreferenced ones.

   -- diagnostics
   with_diagnostics_code(b.diagnostics.eslint_d), -- Injects actions to fix ESLint issues or ignore broken rules. Like ESLint, but faster.
   with_diagnostics_code(b.diagnostics.flake8),
   with_diagnostics_code(b.diagnostics.selene), -- Command line tool designed to help write correct and idiomatic Lua code.
   with_diagnostics_code(b.diagnostics.shellcheck), -- A shell script static analysis tool.

   -- code actions
   -- b.code_actions.gitsigns,
   -- b.code_actions.eslint_d,
   -- b.code_actions.gitrebase,
   -- b.code_actions.refactoring,

   -- hover
   b.hover.dictionary,
}

function M.setup(opts)
   nls.setup {
      -- debug = true,
      debounce = 150,
      save_after_format = false,
      sources = sources,
      on_attach = opts.on_attach,
      root_dir = nls_utils.root_pattern ".git",
   }
end

return M
