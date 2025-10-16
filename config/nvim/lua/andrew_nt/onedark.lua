-- Settings for onedark.nvim
require('onedark').setup({
   highlights = {
      -- Extra treesitter captures that the theme doesn't have
      ['@statement'] = { fg = '$purple', fmt = 'bold' },
      ['@storageclass'] = { fg = '$purple' },
      ['@structure'] = { fg = '$yellow' },
      ['@markup.heading.1.markdown'] = { fg = '$orange', fmt = 'bold' },
      ['@markup.heading.2.markdown'] = { fg = '$green', fmt = 'bold' },
      ['@markup.heading.3.markdown'] = { fg = '$cyan', fmt = 'bold' },
      ['@markup.heading.4.markdown'] = { fg = '$yellow', fmt = 'bold' },
      ['@markup.heading.1.marker.markdown'] = { fg = '$orange', fmt = 'bold' },
      ['@markup.heading.2.marker.markdown'] = { fg = '$green', fmt = 'bold' },
      ['@markup.heading.3.marker.markdown'] = { fg = '$cyan', fmt = 'bold' },
      ['@markup.heading.4.marker.markdown'] = { fg = '$yellow', fmt = 'bold' },
   }
})
require('onedark').load()
