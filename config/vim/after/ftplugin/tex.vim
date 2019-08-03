set tw=80
set spelllang=en_us
set spell

silent! iunmap "
silent! iunmap '
silent! iunmap (
silent! iunmap {
silent! iunmap [

let g:ycm_min_num_of_chars_for_completion = 5

if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme

imap vcc <plug>(vimtex-cmd-create)
