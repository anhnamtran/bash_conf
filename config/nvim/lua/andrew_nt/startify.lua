-- Setup for startify
vim.g.startify_session_dir = vim.g.sessions_dir
vim.g.startify_ascii_header = {
'██████╗  █████╗ ██╗  ██╗██╗     ██╗ █████╗ ',
'██╔══██╗██╔══██╗██║  ██║██║     ██║██╔══██╗',
'██║  ██║███████║███████║██║     ██║███████║',
'██║  ██║██╔══██║██╔══██║██║     ██║██╔══██║',
'██████╔╝██║  ██║██║  ██║███████╗██║██║  ██║',
'╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝╚═╝  ╚═╝',
}
vim.g.startify_custom_header =
  vim.fn['startify#pad'](vim.g.startify_ascii_header)
vim.g.startify_lists = {
  { type = 'commands', header = { '    Commands' } },
  { type = 'sessions', header = { '    Sessions' } },
}
vim.g.startify_commands = {
  { i = { 'init.lua', 'e ~/.config/nvim/init.lua' } },
  { P = { 'Update plugins', 'Lazy update' } },
  { s = { 'Scratch buffer', 'e Scratch | Scratch' } },
}

vim.cmd([[
" BUG: neovim work-around for commit b051b13 which changed line2byte()
"      could submit this change to vim-startify ...
function! s:my_vimenter()
  "if !argc() && line2byte('$') == -1
  if !argc() && line('$') == 1 && getline('.') =~ '^\s*$'
    if get(g:, 'startify_session_autoload') && filereadable('Session.vim')
      source Session.vim
    elseif !get(g:, 'startify_disable_at_vimenter')
      call startify#insane_in_the_membrane(1)
    endif
  endif
  if get(g:, 'startify_update_oldfiles')
    call map(v:oldfiles, 'fnamemodify(v:val, ":p")')
    autocmd startify BufNewFile,BufRead,BufFilePre *
          \ call s:update_oldfiles(expand('<afile>:p'))
  endif
  autocmd! startify VimEnter
endfunction

if has("nvim")
  autocmd VimEnter * nested call s:my_vimenter()
endif
]])
