set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/bundle')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" Plugins
" YouCompleteMe requires Vim 7.4+
Plug 'Valloric/YouCompleteMe'

" Themes and GUIs
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Syntax handling
Plug 'sheerun/vim-polyglot'
Plug 'lervag/vimtex'

" System navigation
Plug 'junegunn/fzf'
Plug 'justinmk/vim-dirvish'
Plug 'christoomey/vim-tmux-navigator'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'kristijanhusak/vim-dirvish-git'

" Session tracking
Plug 'tpope/vim-obsession'

" Utility
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'

" UltiSnips requires Vim 7.4+
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"--------------------end Vundle setup


" -------------------------------- SETTINGS -----------------------------------
" View `man` pages and add new file types
runtime ftplugin/man.vim

" New file types
au BufRead,BufNewFile *.bats set filetype=sh

" Obsession
nnoremap <F10> :Obsession<CR>
nnoremap <C-F10> :Obsession!<CR>

" Dirvish
let g:loaded_netrwPlugin = 1

" Airline
let g:airline_theme='onedark'
let g:airline_highlighting_cache=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#formatter = 'short_path'

" YouCompleteMe settings
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_max_num_candidates = 5
let g:ycm_max_num_identifier_candidates = 5
let g:ycm_filetype_blacklist = {
  \ 'tagbar': 1,
  \ 'notes': 1,
  \ 'markdown': 1,
  \ 'netrw': 1,
  \ 'unite': 1,
  \ 'text': 1,
  \ 'vimwiki': 1,
  \ 'pandoc': 1,
  \ 'infolog': 1,
  \ 'mail': 1,
  \ 'tex' : 1
\}

" Trigger configuration. Do not use <tab>
" if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-Space>"
let g:UltiSnipsJumpForwardTrigger="<c-q>"
let g:UltiSnipsJumpBackwardTrigger="<c-g>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME.'/.UltiSnips']
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsEditSplit = "context"

" Vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'
let g:vimtex_imaps_leader='!'
let g:polyglot_disabled = ['latex']
set conceallevel=1

" Fugitive and GitGutter
set diffopt=vertical
set updatetime=100

" line numbers
set number
" Don't show keys pressed
set noshowcmd

" split windows to the right instead
set splitright
set equalalways

" highlights the current line
set cursorline

" wrapping
set wrap linebreak nolist

" tabbing
set tabstop=2
set shiftwidth=2
set expandtab

set pastetoggle=<F2>
set clipboard=unnamedplus

" search highlighting
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" indenting
set autoindent
set smarttab

" updates file automatically
set autoread
au FocusGained,BufEnter * :checktime

" taking care of files with long lines
" this gives vim a seizure if there are too many long lines
set display+=lastline

" use mouse with tmux
set mouse=a

" enables local vimrc files
set exrc

" enables modeline
set modeline

" --------------------------------- KEYMAPS -----------------------------------
"-------------------------------- INSERT MODE----------------------------------
" Ctrl-S to save
inoremap <c-s> <c-o>:w<CR>

" Replacing `esc` in insert mode
inoremap jj <ESC>
inoremap qq <ESC>:x<CR>

" Auto-close
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" skip closing char
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) ==")" ? "\<Right>" : ")"
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) =="]" ? "\<Right>" : "]"
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) =="}" ? "\<Right>" : "}"
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"
inoremap <expr> ` strpart(getline('.'), col('.')-1, 1) == "\`" ? "\<Right>" : "\`\`\<Left>"
inoremap <expr> . strpart(getline('.'), col('.')-1, 1) == "\." ? "\<Right>" : "."

" quickly edit the previous typo
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

"---------------------------------- NORMAL MODE -------------------------------
nnoremap <CR> o<Esc>
nnoremap <C-CR> O<Esc>
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>

nnoremap <Tab> a<C-Tab><Esc>

" Ctrl+S to save
nnoremap <c-s> :w<CR><x><u>

" Tabs
nnoremap tl :tabn<CR>
nnoremap th :tabp<CR>

" Buffers
nnoremap H :bp<CR>
nnoremap L :bn<CR>
nnoremap <leader>q :bp <BAR> bd #<CR>
nnoremap <leader>ls :ls<CR>

" Remove trailing white spaces
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR><C-o>

" Change current window's directory to current file's
nnoremap <leader>cd :lcd %:p:h<CR>

"------------------------------- EXTRA COMMANDS -------------------------------
command -nargs=+ Grip !grip --quiet <args> &

"------------------------------ EXTRA FUNCTIONS -------------------------------
function! HandleURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
  echo s:uri
  if s:uri != ""
    silent exec "!open '".s:uri."'"
  else
    echo "No URI found in line."
  endif
endfunction
map gx :call HandleURL()<cr>


"-------------------------------- THEMES AND GUI ------------------------------
" Columns limits
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=#4e4e4e

" themes
" 24-bit colors
if &term =~ '256color'
  " disable Background Color Erase (BCE)
  set t_ut=
endif

if !has('nvim')
  set ttymouse=xterm2
endif

if has('termguicolors')
  set termguicolors
endif

syntax on

set background=dark
colorscheme onedark
