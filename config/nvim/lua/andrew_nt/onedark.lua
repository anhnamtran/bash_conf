-- Settings for onedark.nvim
require('onedark').setup({
   highlights = {
      -- Extra treesitter captures that the theme doesn't have
      ['@statement'] = { fg = '$purple', fmt = 'bold' },
      ['@storageclass'] = { fg = '$purple' },
      ['@structure'] = { fg = '$yellow' },
   }
})
require('onedark').load()
