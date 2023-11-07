-- Setup for lualine
local function LuaLineWinNum()
  return vim.api.nvim_win_get_number(0)
end
local function LuaLineObsession()
  return vim.fn.ObsessionStatus("$", "")
end
require("lualine").setup {
  options = {
    theme = 'onedark',
  },
  sections = {
    lualine_a = { LuaLineWinNum, 'mode' },
    lualine_b = { 'branch', 'diff' },
    lualine_c = { 'b:coc_current_function' },
    lualine_x = { 'diagnostics', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location', LuaLineObsession }
   },
  inactive_sections = {
    lualine_a = { LuaLineWinNum },
    lualine_b = {},
    lualine_c = {},
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = { LuaLineObsession }
  },
  tabline = {
    lualine_a = {
      {
        'buffers',
        symbols = { alternate_file = '# ' },
        show_filename_only = false,
      }
    },
    lualine_z = {
      { 'tabs', mode = 2 }
    },
  },
  extensions = {}
}
