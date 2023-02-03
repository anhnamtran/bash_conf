-- Setup for startify
vim.g.startify_session_dir = vim.g.sessions_dir
vim.g.startify_ascii_header = {
  '██╗   ██╗███████╗     ██╗ ██████╗  ██████╗',
  '██║   ██║██╔════╝    ███║██╔════╝ ██╔═████╗',
  '██║   ██║███████╗    ╚██║███████╗ ██║██╔██║',
  '██║   ██║╚════██║     ██║██╔═══██╗████╔╝██║',
  '╚██████╔╝███████║     ██║╚██████╔╝╚██████╔╝',
  ' ╚═════╝ ╚══════╝     ╚═╝ ╚═════╝  ╚═════╝ ',
}
vim.g.startify_custom_header =
  vim.fn['startify#pad'](vim.g.startify_ascii_header)
vim.g.startify_lists = {
  { type = 'commands', header = { '    Commands' } },
  { type = 'sessions', header = { '    Sessions' } },
}
vim.g.startify_commands = {
  { s = { 'Scratch buffer', 'enew | Scratch' } },
  { i = { 'init.lua', 'e ~/.config/nvim/init.lua' } },
  { P = { 'Update plugins', 'PackerUpdate' } },
}
