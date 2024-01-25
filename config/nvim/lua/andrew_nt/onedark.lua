-- Settings for onedark.nvim
require('onedark').setup({
   highlights = {
      -- Extra treesitter captures that the theme doesn't have
      ['@statement'] = { fg = '$purple', fmt = 'bold' },
      ['@storageclass'] = { fg = '$purple' },
      ['@structure'] = { fg = '$yellow' },
      ['@markup.heading.1'] = { fg = '$orange', fmt = 'bold' },
      ['@markup.heading.2'] = { fg = '$green', fmt = 'bold' },
      ['@markup.heading.3'] = { fg = '$cyan', fmt = 'bold' },
      ['@markup.heading.4'] = { fg = '$yellow', fmt = 'bold' },
      ['@markup.heading.1.marker'] = { fg = '$orange', fmt = 'bold' },
      ['@markup.heading.2.marker'] = { fg = '$green', fmt = 'bold' },
      ['@markup.heading.3.marker'] = { fg = '$cyan', fmt = 'bold' },
      ['@markup.heading.4.marker'] = { fg = '$yellow', fmt = 'bold' },
   }
})
require('onedark').load()
