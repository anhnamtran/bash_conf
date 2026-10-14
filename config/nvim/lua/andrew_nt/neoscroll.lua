-- Setup for neoscroll
function EnableSmoothScroll()
  local excluded_filetypes = {'log'}
  local filetype = vim.bo[0].filetype
  if excluded_filetypes[filetype] == nil then
    require('neoscroll').setup {
      easing_function = 'quintic'
    }
  end
end
EnableSmoothScroll()
