-- Settings and configuration for plugins to use nvim-notify
require("notify").setup({
   fps = 30,
   stages = "slide",
   top_down = false,
   max_width = 50,
   max_height = 5,
})

vim.notify = require('notify')

-- coc.nvim notifications
_G.coc_status_record = {}
function _G.coc_status_notify(msg, level)
  local notify_opts = { title = "LSP", timeout = 100, hide_from_history = true, on_close = reset_coc_status_record }
  -- if coc_status_record is not {} then add it to notify_opts to key called "replace"
  if _G.coc_status_record ~= {} then
    notify_opts["replace"] = _G.coc_status_record.id
  end
  _G.coc_status_record = vim.notify(msg, level, notify_opts)
end

function _G.reset_coc_status_record(window)
  _G.coc_status_record = {}
end

_G.coc_diag_record = {}

function _G.coc_diag_notify(msg, level)
  local notify_opts = { title = "LSP", timeout = 500, on_close = reset_coc_diag_record }
  -- if coc_diag_record is not {} then add it to notify_opts to key called "replace"
  if _G.coc_diag_record ~= {} then
    notify_opts["replace"] = _G.coc_diag_record.id
  end
  _G.coc_diag_record = vim.notify(msg, level, notify_opts)
end

function _G.reset_coc_diag_record(window)
  _G.coc_diag_record = {}
end

vim.cmd([[
function! s:DiagnosticNotify() abort
  let l:info = get(b:, 'coc_diagnostic_info', {})
  if empty(l:info) | return '' | endif
  let l:msgs = []
  let l:level = 'info'
  if get(l:info, 'warning', 0)
    let l:level = 'warn'
  endif
  if get(l:info, 'error', 0)
    let l:level = 'error'
  endif
 
  if get(l:info, 'error', 0)
    call add(l:msgs, ' Errors: ' . l:info['error'])
  endif
  if get(l:info, 'warning', 0)
    call add(l:msgs, ' Warnings: ' . l:info['warning'])
  endif
  if get(l:info, 'information', 0)
    call add(l:msgs, ' Infos: ' . l:info['information'])
  endif
  if get(l:info, 'hint', 0)
    call add(l:msgs, ' Hints: ' . l:info['hint'])
  endif
  let l:msg = join(l:msgs, "\n")
  if empty(l:msg) | let l:msg = ' All OK' | endif
  call v:lua.coc_diag_notify(l:msg, l:level)
endfunction

function! s:InitCoc() abort
  execute "lua vim.notify('Initialized coc.nvim for LSP support', 'info', { title = 'CoC.nvim', timeout = 300 })"
endfunction

" notifications
autocmd User CocNvimInit call s:InitCoc()
autocmd User CocDiagnosticChange call s:DiagnosticNotify()
autocmd User CocStatusChange call s:StatusNotify()
]])

-- Buffer notification
vim.api.nvim_create_autocmd({'FileChangedShellPost'}, {
  pattern = {"*"},
  callback = function() vim.notify("Buffer reloaded", vim.log.levels.WARN) end
})

