-- Load arista specific settings
if vim.fn.filereadable('/usr/share/vim/vimfiles/arista.vim') == 1 then
  if vim.g.arista_vim ~= 1 then
    vim.cmd([[source /usr/share/vim/vimfiles/arista.vim]])
    vim.opt.tabstop = 3
    vim.g.arista_vim = 1
  end
end
