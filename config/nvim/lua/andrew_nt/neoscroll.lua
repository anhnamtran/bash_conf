-- Setup for neoscroll
function EnableSmoothScroll()
  local excluded_filetypes = {'log'}
  local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
  if excluded_filetypes[filetype] == nil then
    require('neoscroll').setup {
      easing_function = 'quintic'
    }
  end
end
EnableSmoothScroll()
