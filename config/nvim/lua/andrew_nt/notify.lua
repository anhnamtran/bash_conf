-- Settings and configuration for plugins to use nvim-notify
require("notify").setup({
   fps = 30,
   stages = "slide",
   top_down = false,
   max_width = 50,
   max_height = 5,
   icons = {
     DEBUG = " ",
     ERROR = " ",
     INFO = " ",
     TRACE = "✎ ",
     WARN = " "
   },
})

vim.notify = require('notify')

-- coc.nvim notifications
local coc_status_record = {}

local function reset_coc_status_record(window)
  coc_status_record = {}
end

local function notify_coc_status(msg, level)
  local notify_opts = {
    title = "LSP Status",
    timeout = 500,
    hide_from_history = true,
    on_close = reset_coc_status_record
  }
  -- if coc_status_record is not {} then add it to notify_opts to key called "replace"
  if coc_status_record ~= {} then
    notify_opts["replace"] = coc_status_record.id
  end
  coc_status_record = vim.notify(msg, level, notify_opts)
end

local coc_diag_record = {}

local function reset_coc_diag_record(window)
  coc_diag_record = {}
end

local function notify_coc_diag(msg, level)
  local notify_opts = {
    title = "LSP Diagnostics",
    timeout = 500,
    on_close = reset_coc_diag_record
  }
  -- if coc_diag_record is not {} then add it to notify_opts to key called "replace"
  if coc_diag_record ~= {} then
    notify_opts["replace"] = coc_diag_record.id
  end
  coc_diag_record = vim.notify(msg, level, notify_opts)
end

local previous_diag = nil

local function coc_notify_diagnostics()
  local info = vim.b.coc_diagnostic_info
  if info == nil then
     return
  end
  local msgs = {}
  local level = vim.log.levels.INFO
  if info.warning ~= nil and info.warning > 0 then
    level = vim.log.levels.WARN
  end
  if info.error ~= nil and info.error > 0 then
    level = vim.log.levels.ERROR
  end
 
  if info.error ~= nil and info.error > 0 then
    table.insert(msgs, '  Errors: ' .. info.error)
  end
  if info.warning ~= nil and info.warning > 0 then
    table.insert(msgs, '  Warnings: ' .. info.warning)
  end
  if info.information ~= nil and info.information > 0 then
    table.insert(msgs, '  Infos: ' .. info.information)
  end
  if info.hint ~= nil and info.hint > 0 then
    table.insert(msgs, '✎ Hints: ' .. info.hint)
  end

  local msg = table.concat(msgs, "\n")
  if msg == previous_diag then
     return
  end
  if #msg == 0 then
    msg = '  All OK'
  end

  previous_diag = msg
  notify_coc_diag(msg, level)
end

local previous_status = nil
local function coc_notify_status()
  local status = vim.g.coc_status
  local level = vim.log.levels.INFO
  if status == nil or status == "" or status == previous_status then
     return
  end
  previous_status = status
  notify_coc_status(status, level)
end

local function coc_notify_init()
  vim.notify('Initialized coc.nvim for LSP support',
             vim.log.levels.INFO,
             { title = 'LSP Status', timeout = 250 })
end

-- notifications
vim.api.nvim_create_autocmd({'User'}, {
  pattern = "CocNvimInit",
  callback = coc_notify_init
})
vim.api.nvim_create_autocmd({'User'}, {
  pattern = "CocDiagnosticChange",
  callback = coc_notify_diagnostics
})
vim.api.nvim_create_autocmd({'User'}, {
  pattern = "CocStatusChange",
  callback = coc_notify_status
})

-- Buffer notification
vim.api.nvim_create_autocmd({'FileChangedShellPost'}, {
  pattern = {"*"},
  callback = function() vim.notify("Buffer reloaded", vim.log.levels.WARN) end
})

-- notify clipboard copy
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup("osc52-au", {}),
  callback = function(opts)
    local force = opts.data ~= nil and opts.data.force ~= nil and opts.data.force
    if force or (vim.v.event.operator == 'y' and (vim.v.event.regname == '+' or vim.v.event.regname == '*')) then
      -- schedule to avoid this notify call from interacting with vim fast events
      vim.schedule(function () vim.notify("Text copied into clipboard", vim.log.levels.INFO) end)
    end
  end
})
