-- Setup for indent_blankline
require("ibl").setup {
    indent = {
        char = "▏",
    },
    exclude = {
        buftypes = { "terminal", "help" },
        filetypes = { "vimwiki", "markdown" },
    },
    scope = {
      enabled = true
  }
}
vim.cmd([[
hi! link IndentBlankLineChar NonText
]])
