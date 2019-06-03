set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = $runtimmepath
source ~/.vimrc

au TermOpen * setlocal nospell
set guicursor=
