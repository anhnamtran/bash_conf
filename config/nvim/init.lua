-- Cached plugin loading using impatient.nvim
require('impatient')
-- be iMproved and encoding settings
vim.opt.compatible = false
vim.opt.encoding = 'utf-8'

-- load plugins from packer
require('plugins')
require('arista')

-- Utility plugins configuration
require('andrew_nt.obsession')
require('andrew_nt.startify')
require('andrew_nt.neoscroll')
require('andrew_nt.hop')
require('andrew_nt.nvim-tmux-navigation')
require('andrew_nt.telescope')
require('andrew_nt.nvim-autopairs')
require('andrew_nt.other')
require('andrew_nt.nvim-osc52')
require('andrew_nt.scratch')

-- Syntax plugins configuration
require('andrew_nt.onedark')
require('andrew_nt.treesitter')
require('andrew_nt.indent_blankline')
require('andrew_nt.lualine')
require('andrew_nt.gitsigns')
require('andrew_nt.coc')

-- VimL settings

-- color columns and textwidth
if vim.g.arista_vim ~= 1 then
  vim.opt.textwidth = 80
end
vim.opt.colorcolumn = '+0'
-- unset colorcolumn for inactive windows
vim.api.nvim_create_autocmd({'WinEnter', 'WinLeave'}, {
  group = vim.api.nvim_create_augroup('ActiveWin', {}),
  pattern = '*',
  callback = function (args)
    if args.event == 'WinEnter' then
      vim.opt.colorcolumn = '+0'
    else
      vim.opt.colorcolumn = '0'
    end
  end
})

-- tabbing and indentation
if vim.g.arista_vim ~= 1 then
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
end
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smarttab = true

-- Workaround for editing files that have been installed via symlink
vim.opt.backupdir = { '/home/andrew_nt/.local/state/nvim/backup/' }

-- wildmenu settings
vim.opt.wildmenu = true
vim.opt.wildignorecase = true
vim.opt.wildmode = 'longest,full'

-- lower update time
vim.opt.updatetime = 100

-- diff view settings
vim.opt.diffopt = 'filler,context:5'
vim.opt.foldopen:remove { 'search' }

-- make jumplist behave like tag stack
vim.opt.jumpoptions:append { 'stack' }

-- enable line numbers
vim.opt.number = true
-- don't show keys pressed
vim.opt.showcmd = false

-- always split windows to the right and resize panes to be equal
vim.opt.splitright = true
vim.opt.equalalways = true

-- line wrapping
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.list = false

-- seearch highlighting settings
vim.opt.hlsearch = true
vim.keymap.set('n', '<Space>', ':nohlsearch<Bar>:echo<CR>',
               { noremap = true, silent = true })

-- update files automatically
vim.opt.autoread = true
-- Trigger `autoread` when files changes on disk
-- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
-- https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
-- Notification after file change
-- https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter'}, {
  pattern = {"*"},
  command = "if mode() != 'c' | checktime | endif"
})
vim.api.nvim_create_autocmd({'FileChangedShellPost'}, {
  pattern = {"*"},
  command = 'echohl WarningMsg | echo "Buffer reloaded." | echohl None'
})

-- handle files with long lines, can cause issues if there are too many long
-- lines
vim.opt.display:append { 'lastline' }

-- enables local vimrc files
vim.opt.exrc = true
vim.opt.secure = true

-- enables the modeline
vim.opt.modeline = true

-- lower the timeout between mapped sequences and key codes
vim.opt.timeoutlen = 200
vim.opt.ttimeoutlen = 100

-- enable smart case searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

local WinRelNum = vim.api.nvim_create_augroup('WinRelNum', {})
vim.api.nvim_create_autocmd({'WinEnter', 'WinLeave'}, {
  group = WinRelNum,
  pattern = '*',
  callback = function(args)
    vim.opt.relativenumber = args.event == 'WinEnter'
  end
})
vim.api.nvim_create_autocmd({'BufWinEnter'}, {
  group = WinRelNum,
  buffer = 0,
  callback = function()
    vim.opt.relativenumber = true
  end
})

-- make grep use ripgrep instead
vim.opt.grepprg = 'rg --vimgrep'
vim.opt.grepformat:prepend { '%f:%l:%c:%m' }

-- make buffer switching use opened, tabbed, or last buffer
vim.opt.switchbuf = {'useopen', 'usetab', 'uselast'}

-- highlight the current line
vim.opt.cursorline = true

-- disable Backgorund Color Erase and enable 24-bit colors
vim.cmd([[
if &term =~ '256color'
  set t_ut=
endif
]])

-- enable termguicolors
vim.opt.termguicolors = true

-- highlight trailing whitespaces
vim.api.nvim_create_autocmd(
  {'BufWinEnter', 'BufWinLeave', 'InsertEnter', 'InsertLeave', 'TermOpen'}, {
  group = vim.api.nvim_create_augroup('ExtraWhiteSpaceHi', {}),
  pattern = '*',
  callback = function(args)
    local is_terminal = vim.api.nvim_buf_get_option(0, 'buftype') == 'terminal'
    vim.cmd([[match DiffDelete /\s\+$/]])
    if args.event == 'InsertEnter' then
      vim.cmd([[match DiffDelete /\s\+\%#\@<!$/]])
    elseif args.event == 'BufWinLeave' or is_terminal then
      vim.fn.clearmatches()
    else
      vim.cmd([[match DiffDelete /\s\+$/]])
    end
  end
})

-- load large files faster this disables syntax highlighting temporarily
vim.api.nvim_create_autocmd({'BufReadPre'}, {
  group = vim.api.nvim_create_augroup('LargeFiles', {}),
  pattern = '*',
  callback = function()
    local maxSize = 1024 * 1024 * 10
    local fileSize = vim.fn.getfsize(vim.fn.expand("<afile>"))
    if (fileSize > maxSize) or (fileSize == -2) then
      -- no syntax highlighting
      vim.opt.eventignore:append('FileType')

      -- save memory when other file is viewed by unloading the buffer
      vim.opt_local.bufhidden = 'unload'

      -- is read-only
      vim.opt_local.buftype = 'nowrite'

      -- no undo
      vim.opt_local.undolevels = -1

      -- display message about large file
      print("File is too large " .. fileSize .. "/" .. maxSize .. ", some settings are disabled. Enable syntax by running :LargeSyntax")

      vim.api.nvim_create_user_command('LargeSyntax', function()
        local eventignore = vim.opt.eventignore:get()
        for index, value in ipairs(eventignore) do
          if value == 'FileType' then
            vim.opt.eventignore:remove(value)
          end
          vim.opt.syntax = 'on'
        end
      end, {})
    end
  end
})

-- cindent options
vim.opt.cinoptions = 'N-s'

-- enable syntax. Doing this at the end-ish because this can take a while on
-- large files
vim.opt.syntax = 'enable'

---------------------------------- KEYMAPS ------------------------------------
local function imap(shortcut, command, noremap)
  vim.keymap.set('i', shortcut, command, { noremap = noremap, silent = true })
end
local function nmap(shortcut, command, noremap)
  vim.keymap.set('n', shortcut, command, { noremap = noremap, silent = true })
end
local function vmap(shortcut, command, noremap)
  vim.keymap.set('v', shortcut, command, { noremap = noremap, silent = true })
end
local function tmap(shortcut, command, noremap)
  vim.keymap.set('t', shortcut, command, { noremap = noremap, silent = true })
end

-- insert mode
-- Ctrl-S to save
imap('<C-s>', '<C-o>:w<CR>', true)

-- replace ESC in insert mode
imap('jj', '<ESC>', true)
imap('qq', '<ESC>:x<CR>', true)

-- quickly edit the previous typo
imap('<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u', true)

-- normal mode
nmap('<CR>', 'o<ESC>', true)
-- allow ENTER to be used in command window and quickfix windows
local CRFix = vim.api.nvim_create_augroup('CRFix', {})
vim.api.nvim_create_autocmd({'CmdwinEnter'}, {
  group = CRFix,
  pattern = '*',
  command = 'nnoremap <CR> <CR>'
})
vim.api.nvim_create_autocmd({'BufReadPost'}, {
  group = CRFix,
  pattern = 'quickfix',
  command = 'nnoremap <CR> <CR>'
})

-- Ctrl+S to save
nmap('<C-s>', ':w<CR>', true)

-- tabs navigation
nmap('tl', ':tabn<CR>', true)
nmap('th', ':tabp<CR>', true)
nmap('tc', ':tabc<CR>', true)

-- buffers navigation
nmap('H', ':bp<CR>', true)
nmap('L', ':bn<CR>', true)
nmap('<leader>q', ':bp <BAR> bd #<CR>', true)
nmap('<leader>ls', ':ls<CR>', true)

-- remove trailing white spaces
-- I don't quite know how to do this in lua
vim.cmd([[
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
]])

-- change the current window's cwd to the current file's
nmap('<leader>cd', ':lcd %:p:h<CR>', true)

-- jump to the last window
nmap('<C-w>;', ':wincmd p<CR>')
-- maximize the current window
nmap('<C-w>z', ':MaximizerToggle')
-- open nerdtree
nmap('<C-n>n', ':NERDTreeToggle<CR>')

-- buffer control
vim.cmd([[
function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! OpenOnly :call DeleteInactiveBufs()
nnoremap <C-w>b :OpenOnly<CR>
]])

-- terminal mappings and commands
tmap('<ESC>', '<C-\\><C-n>')
tmap('<C-l>', '<C-\\><C-n><Cmd>NvimTmuxNavigateRight<CR>')
tmap('<C-h>', '<C-\\><C-n><Cmd>NvimTmuxNavigateLeft<CR>')
tmap('<C-j>', '<C-\\><C-n><Cmd>NvimTmuxNavigateDown<CR>')
tmap('<C-k>', '<C-\\><C-n><Cmd>NvimTmuxNavigateUp<CR>')

-- always enter insertmode when entering terminal
vim.api.nvim_create_autocmd({'BufWinEnter', 'WinEnter', 'FocusGained'}, {
   pattern = 'term://*',
   callback = function(args)
      vim.cmd.startinsert()
   end
})

----------------------------------- THEMES -------------------------------------

vim.opt.background = 'dark'
vim.cmd([[colorscheme onedark]])

-- additional scheme and highlighting changes
-- these need to be after 'colorscheme' incase that clears highlight groups
vim.opt.pumblend = 15
vim.cmd([[
hi! PmenuSel ctermfg=235 ctermbg=170 guifg=#282C34 guibg=#C678DD
hi! link CocHighlightText Title
hi! link CocMenuSel PmenuSel
]])
