local M = {}

function M.setup()
  require("refactoring").setup({
    prompt_func_return_type = {
      go = true,
    },
    prompt_func_param_type = {
      go = true,
    },
  })
  if PLUGINS.telescope.enabled then

  require("telescope").load_extension("refactoring")
  end
end

return M
