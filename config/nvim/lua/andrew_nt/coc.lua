-- Setup for coc.nvim
vim.cmd([[
function! s:disable_coc_for_type()
  let l:filesuffix_denylist = ['log', 'qt']
	if index(l:filesuffix_denylist, expand('%:e')) != -1
	  let b:coc_enabled = 0
	endif
endfunction
augroup CocCustomAu
  au!
  autocmd! BufRead,BufNewFile * call s:disable_coc_for_type()
  autocmd! BufEnter,FocusGained * silent call CocActionAsync("ensureDocument")
  autocmd! BufEnter,FocusGained * silent call CocActionAsync("refreshSource")
  autocmd! FileType json,cpp,vim,tacc,python setl formatexpr=CocAction('formatSelected')
augroup END

autocmd CursorHold * silent call CocActionAsync('highlight')

set tagfunc=CocTagFunc

let g:coc_global_extension = [
\  'coc-yaml',
\  'coc-vimlsp',
\  'coc-tsserver',
\  'coc-sh',
\  'coc-pyright',
\  'coc-json',
\  'coc-jedi',
\  'coc-html',
\  'coc-css',
\  'coc-clangd',
\  'coc-fish',
\  'coc-spell-checker',
\  'coc-rust-analyzer',
\  'coc-lua',
\]

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.

" remap all Coc's <Plug> mappings to use CocActionAsync
nnoremap <Plug>(coc-definition) :CocActionAsync('jumpDefinition')
nnoremap <Plug>(coc-type-definition) :CocActionAsync('jumpTypeDefinition')
nnoremap <Plug>(coc-implementation) :CocActionAsync('jumpImplementation')
nnoremap <Plug>(coc-references) :CocActionAsync('jumpReferences')
nnoremap <Plug>(coc-rename) :CocActionAsync('rename')
nnoremap <Plug>(coc-codeaction) :CocActionAsync('codeAction', '')
nnoremap <Plug>(coc-codeaction-cursor) :CocActionAsync('codeAction', 'cursor')

" Tab completion
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
\ coc#pum#visible() ? coc#pum#next(1):
\ <SID>check_back_space() ? "\<Tab>" :
\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" <CR> will confirm an item if something is selected, else, it'll just act like
" <Enter>
inoremap <silent><expr> <CR> coc#pum#visible() && coc#pum#info()['index'] < 0 ? "\<CR>" :
        \ coc#pum#visible() && coc#pum#info()['index'] != -1 ? coc#pum#confirm() :
        \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

inoremap <silent><expr> <c-space> coc#refresh()
]])
