-- Setup for startify
vim.cmd([[
let g:startify_session_dir = g:sessions_dir
let g:startify_ascii_header = [
      \ ' █████╗  ███╗   ██╗ ██████╗  ██████╗  ███████╗ ██╗    ██╗',
      \ '██╔══██╗ ████╗  ██║ ██╔══██╗ ██╔══██╗ ██╔════╝ ██║    ██║',
      \ '███████║ ██╔██╗ ██║ ██║  ██║ ██████╔╝ █████╗   ██║ █╗ ██║',
      \ '██╔══██║ ██║╚██╗██║ ██║  ██║ ██╔══██╗ ██╔══╝   ██║███╗██║',
      \ '██║  ██║ ██║ ╚████║ ██████╔╝ ██║  ██║ ███████╗ ╚███╔███╔╝',
      \ '╚═╝  ╚═╝ ╚═╝  ╚═══╝ ╚═════╝  ╚═╝  ╚═╝ ╚══════╝  ╚══╝╚══╝',
      \]
let g:startify_custom_header = startify#pad(g:startify_ascii_header)
let g:startify_lists = [
      \ { 'type': 'commands',  'header': ['   Commands']        },
      \ { 'type': 'sessions',  'header': ['   Sessions']        },
      \ { 'type': 'files',     'header': ['   FILES']           },
      \ { 'type': 'dir',       'header': ['   DIRS '. getcwd()] },
      \ ]
let g:startify_commands = [
      \ {'v': ['vimrc', 'e ~/.vimrc']},
      \ {'P': ['Update plugins', 'PlugUpdate']},
      \ {'w': ['VimWiki Index', 'VimwikiIndex']},
      \ {'d': ['VimWiki Diary', 'VimwikiDiary']},
      \ {'D': ['VimWiki Diary Index', 'VimwikiDiaryIndex']},
      \ ]
]])
