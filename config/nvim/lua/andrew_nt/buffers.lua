-- Settings and controls for buffers
-- make buffer switching use opened, tabbed, or last buffer
vim.opt.switchbuf = {'useopen', 'usetab', 'uselast'}

-- buffers navigation
local function nmap(shortcut, command, noremap)
  vim.keymap.set('n', shortcut, command, { noremap = noremap, silent = true })
end

nmap('H', ':bp<CR>', true)
nmap('L', ':bn<CR>', true)
-- Use vim-bbye if possible
if require("lazy.core.config").plugins["vim-bbye"] ~= nil then
   nmap('<leader>q', ':Bwipeout #<CR>', true)
else
   nmap('<leader>q', ':bp <BAR> bwipeout #<CR>', true)
end
nmap('<leader>ls', ':ls<CR>', true)

local function DeleteInactiveBufs()
  local nbufs = 0
  local visiblebufs = {}
  for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
     local bufs = vim.fn.tabpagebuflist(tab)
     visiblebufs = vim.tbl_extend("keep", visiblebufs, bufs)
  end
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    -- The buffer is valid, is not modified, and exists in the buffer list
    if vim.api.nvim_buf_is_valid(buf) and not vim.api.nvim_buf_get_option(buf, "modified") and not vim.tbl_contains(visiblebufs, buf) then
      if require("lazy.core.config").plugins["vim-bbye"] ~= nil then
        vim.cmd["Bwipeout"](buf)
      else
        vim.cmd.bwipeout(buf)
      end
      nbufs = nbufs + 1
    end
  end
  vim.notify(nbufs .. " buffer(s) wiped out", vim.log.levels.INFO)
end
vim.api.nvim_create_user_command("OpenOnly", DeleteInactiveBufs, {})
nmap("<C-w>b", ":OpenOnly")
