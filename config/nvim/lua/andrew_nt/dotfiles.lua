-- Configs for dotfile management using git and fugitive
if vim.g.loaded_fugitive == nil then
  vim.notify("Fugitive not loaded", vim.log.levels.ERROR)
end

vim.api.nvim_create_user_command("Configs", function ()
  vim.fn["FugitiveDetect"](vim.fn.expand("~/.cfg"))
end, { nargs = 0 })
