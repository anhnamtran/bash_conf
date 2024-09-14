-- Setup for rainbow-delimiters.nvim
-- This module contains a number of default definitions
local rainbow_delimiters = require 'rainbow-delimiters'
require('rainbow-delimiters.setup').setup({
    strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    priority = {
        [''] = 110,
        lua = 210,
    },
    blacklist = { "help", "log", "qt", "wiki", "vimdoc", "vim" },
})
