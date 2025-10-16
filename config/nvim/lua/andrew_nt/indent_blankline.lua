-- Setup for indent_blankline
require("ibl").setup {
    indent = {
        char = "▏",
        highlight = "NonText"
    },
    exclude = {
        buftypes = { "terminal", "help" },
        filetypes = { "vimwiki", "markdown" },
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
      highlight = "String"
  }
}
