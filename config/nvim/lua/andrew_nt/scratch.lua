-- Create scratch buffers more easily
-- :h scratch
vim.api.nvim_create_user_command('Scratch',
  function(opts)
    vim.opt_local.swapfile = false
    vim.opt_local.buftype = 'nofile'
    vim.opt_local.bufhidden = 'hide'
  end,
{})
