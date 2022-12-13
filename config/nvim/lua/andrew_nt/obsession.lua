-- Setup for tpope/obsession
vim.g.sessions_dir = '~/.cache/nvim/sessions'
vim.g.sessionoptions = 'buffers,curdir,folds,help,tabpages,winsize'
vim.cmd([[
exec 'nnoremap <leader>ss :Obsession! ' . g:sessions_dir . '/*.vim<C-D><Left><Left><Left><Left><BS>'
exec 'nnoremap <leader>sr :so ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
nnoremap <leader>sp :Obsession<CR>
nnoremap <leader>sc :echo v:this_session<CR>
nnoremap <leader>sl :exec 'mksession!' . v:this_session<CR>
nnoremap <leader>sd :Obsession!<CR>
]])
