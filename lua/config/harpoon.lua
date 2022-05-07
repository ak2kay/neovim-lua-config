local M = {}

function M.setup()
  require("harpoon").setup({
    global_settings = {
      save_on_toggle = true,
      enter_on_sendcmd = true,
    },
  })
  if PLUGINS.telescope.enabled then
    require("telescope").load_extension("harpoon")
  end
end

return M
