-- Setup for indent_blankline
require("ibl").setup {
    char = "▏",
    buftype_exclude = { "terminal", "help" },
    filetype_exclude = { "vimwiki", "markdown" },
    use_treesitter = true,
    show_current_context = true,
}
vim.cmd([[
hi! link IndentBlankLineChar NonText
]])
