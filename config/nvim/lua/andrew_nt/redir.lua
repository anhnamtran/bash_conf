-- Allow redirecting internal ex-command output to a temp buffer
vim.api.nvim_create_user_command('Redir', function(ctx)
  local lines = vim.split(vim.api.nvim_exec2(ctx.args, { output = true }).output, '\n', { plain = true })
  vim.cmd('new')
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.opt_local.modified = false
end, { nargs = '+', complete = 'command' })
